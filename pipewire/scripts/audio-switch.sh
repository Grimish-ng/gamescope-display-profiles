#!/bin/bash
# audio-switch.sh
# Switches between audio output chains.
#
# Spatial chains (no dynamics - direct to spatial processor):
#   All audio → spatial sink → hardware output
#
# Direct chains (dynamics processing on stereo hardware output):
#   All audio → Dynamics Processor (compress + limit) → hardware output
#
# Usage: audio-switch.sh [aux|hdmi-dolby|hdmi-matrix|bt|direct-aux|direct-hdmi|status]

# ── Sink names ────────────────────────────────────────────────────────────────
DYNAMICS="Dynamics-Processor"
HW_HDMI="alsa_output.pci-0000_03_00.1.hdmi-stereo"
HW_AUX="alsa_output.pci-0000_07_00.6.pro-output-0"
DOLBY_AUX="Dolby-Pro-Logic-II"
DOLBY_HDMI="Dolby-Pro-Logic-II-HDMI"
DOLBY_BT="Dolby-Pro-Logic-II-BT"
MATRIX_HDMI="Matrix-Spatialiser-HDMI"

# ── Port names ────────────────────────────────────────────────────────────────
DYN_L="Dynamics-Processor-Output:output_FL"
DYN_R="Dynamics-Processor-Output:output_FR"

HW_HDMI_L="alsa_output.pci-0000_03_00.1.hdmi-stereo:playback_FL"
HW_HDMI_R="alsa_output.pci-0000_03_00.1.hdmi-stereo:playback_FR"
HW_AUX_L="alsa_output.pci-0000_07_00.6.pro-output-0:playback_AUX0"
HW_AUX_R="alsa_output.pci-0000_07_00.6.pro-output-0:playback_AUX1"

# All possible dynamics targets for cleanup
ALL_DYN_TARGETS=(
    "$HW_HDMI_L" "$HW_HDMI_R"
    "$HW_AUX_L"  "$HW_AUX_R"
)

# ── Helper functions ──────────────────────────────────────────────────────────
sink_exists() {
    pactl list sinks short | grep -q "$1"
}

unlink_dynamics() {
    for target in "${ALL_DYN_TARGETS[@]}"; do
        pw-link --disconnect "$DYN_L" "$target" 2>/dev/null
        pw-link --disconnect "$DYN_R" "$target" 2>/dev/null
    done
}

set_spatial_chain() {
    local target_sink="$1"
    local label="$2"

    if ! sink_exists "$target_sink"; then
        echo "ERROR: Sink '$target_sink' not found."
        exit 1
    fi

    echo "Setting spatial chain:"
    echo "  All audio → ${label}"
    echo ""

    # Disconnect dynamics from hardware (not needed for spatial path)
    unlink_dynamics

    # Set spatial sink as default - it handles its own routing to hardware
    pactl set-default-sink "$target_sink"
    echo "Done."
}

set_direct_chain() {
    local target_sink="$1"
    local target_l="$2"
    local target_r="$3"
    local label="$4"

    if ! sink_exists "$DYNAMICS"; then
        echo "ERROR: Dynamics Processor not found. Check 99-dynamics.conf."
        exit 1
    fi
    if ! sink_exists "$target_sink"; then
        echo "ERROR: Sink '$target_sink' not found."
        exit 1
    fi

    echo "Setting direct chain with dynamics:"
    echo "  All audio → Dynamics Processor → ${label}"
    echo ""

    # Disconnect any existing dynamics links first
    unlink_dynamics

    # Set dynamics as default
    pactl set-default-sink "$DYNAMICS"

    # Link dynamics output to hardware sink
    pw-link "$DYN_L" "$target_l" && \
    pw-link "$DYN_R" "$target_r" && \
    echo "Done." || \
    echo "ERROR: Failed to link ports. Run 'audio-switch.sh status' to debug."
}

# ── Main ──────────────────────────────────────────────────────────────────────
case "$1" in
    aux)
        set_spatial_chain \
            "$DOLBY_AUX" \
            "5.1 Surround (Dolby Pro Logic II) Aux → headphone jack"
        ;;
    hdmi-dolby)
        set_spatial_chain \
            "$DOLBY_HDMI" \
            "5.1 Surround (Dolby Pro Logic II) HDMI → monitor aux"
        ;;
    hdmi-matrix)
        set_spatial_chain \
            "$MATRIX_HDMI" \
            "Stereo Spatial (Matrix Spatialiser) HDMI → monitor aux"
        ;;
    bt)
        set_spatial_chain \
            "$DOLBY_BT" \
            "5.1 Surround (Dolby Pro Logic II) BT → Bluetooth SBC-XQ"
        ;;
    direct-hdmi)
        set_direct_chain \
            "$HW_HDMI" "$HW_HDMI_L" "$HW_HDMI_R" \
            "Navi 31 HDMI/DP Audio (stereo + dynamics)"
        ;;
    direct-aux)
        set_direct_chain \
            "$HW_AUX" "$HW_AUX_L" "$HW_AUX_R" \
            "Ryzen HD Audio Controller (stereo + dynamics)"
        ;;
    status)
        echo "Current default sink : $(pactl get-default-sink)"
        echo ""
        echo "Active Dynamics links:"
        pw-link -l 2>/dev/null | grep -A2 "Dynamics-Processor-Output" | grep -v "^--$"
        echo ""
        echo "All sinks:"
        pactl list sinks short
        ;;
    *)
        echo "Usage: audio-switch.sh <mode>"
        echo ""
        echo "  Spatial (no dynamics):"
        echo "    aux          → Dolby PLII     → headphone/aux jack"
        echo "    hdmi-dolby   → Dolby PLII     → HDMI → monitor aux"
        echo "    hdmi-matrix  → Matrix Spatial → HDMI → monitor aux"
        echo "    bt           → Dolby PLII     → Bluetooth SBC-XQ"
        echo ""
        echo "  Direct stereo (with dynamics: compress + limit):"
        echo "    direct-hdmi  → Dynamics → Navi 31 HDMI/DP Audio"
        echo "    direct-aux   → Dynamics → Ryzen HD Audio Controller"
        echo ""
        echo "  Info:"
        echo "    status       → show current chain and active links"
        exit 1
        ;;
esac
