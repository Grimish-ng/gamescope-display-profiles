#!/bin/bash
# audio-switch.sh
# Routes the Dynamics Processor to a chosen output sink
# and sets the full chain as the system default.
#
# Signal chain:
#   All audio → Dynamics Processor (compress + limit)
#             → chosen output sink
#             → hardware output
#
# Usage: audio-switch.sh [aux|hdmi-dolby|hdmi-matrix|bt]

# ── Sink names ────────────────────────────────────────────────────────────────
DYNAMICS="Dynamics-Processor"
DYNAMICS_OUTPUT="Dynamics-Processor-Output"

DOLBY_AUX="Dolby-Pro-Logic-II"
DOLBY_HDMI="Dolby-Pro-Logic-II-HDMI"
DOLBY_BT="Dolby-Pro-Logic-II-BT"
MATRIX_HDMI="Matrix-Spatialiser-HDMI"

# ── Helper functions ──────────────────────────────────────────────────────────
sink_exists() {
    pactl list sinks short | grep -q "$1"
}

link_dynamics_to() {
    local target="$1"
    # pw-link connects the dynamics output node to the target sink input node
    # First unlink any existing connections from dynamics output
    pw-link --disconnect "${DYNAMICS_OUTPUT}:output_FL" 2>/dev/null
    pw-link --disconnect "${DYNAMICS_OUTPUT}:output_FR" 2>/dev/null
    # Link to new target
    pw-link "${DYNAMICS_OUTPUT}:output_FL" "${target}:input_FL"
    pw-link "${DYNAMICS_OUTPUT}:output_FR" "${target}:input_FR"
}

set_chain() {
    local target_sink="$1"
    local target_label="$2"

    if ! sink_exists "$DYNAMICS"; then
        echo "ERROR: Dynamics Processor sink not found."
        echo "       Make sure 99-dynamics.conf is loaded."
        exit 1
    fi

    if ! sink_exists "$target_sink"; then
        echo "ERROR: Sink '$target_sink' not found."
        echo "       Make sure the relevant conf file is loaded."
        exit 1
    fi

    echo "Setting audio chain:"
    echo "  All audio → Dynamics Processor → ${target_label}"
    echo ""

    # Set Dynamics Processor as the default sink
    # (all apps send audio here first)
    pactl set-default-sink "$DYNAMICS"

    # Link dynamics output to the chosen downstream sink
    link_dynamics_to "$target_sink"

    echo "Active chain:"
    echo "  Default sink : $DYNAMICS"
    echo "  Output sink  : $target_sink"
    echo "  Hardware out : $(pactl list sinks short | grep "$target_sink" | awk '{print $1}')"
    echo ""
    echo "Done. Use 'pactl get-default-sink' to verify."
}

# ── Main ──────────────────────────────────────────────────────────────────────
case "$1" in
    aux)
        set_chain "$DOLBY_AUX" "5.1 Surround (Dolby Pro Logic II) Aux → headphone jack"
        ;;
    hdmi-dolby)
        set_chain "$DOLBY_HDMI" "5.1 Surround (Dolby Pro Logic II) HDMI → monitor aux"
        ;;
    hdmi-matrix)
        set_chain "$MATRIX_HDMI" "Stereo Spatial (Matrix Spatialiser) HDMI → monitor aux"
        ;;
    bt)
        set_chain "$DOLBY_BT" "5.1 Surround (Dolby Pro Logic II) BT → Bluetooth SBC-XQ"
        ;;
    status)
        echo "Current default sink: $(pactl get-default-sink)"
        echo ""
        echo "All active sinks:"
        pactl list sinks short
        ;;
    *)
        echo "Usage: audio-switch.sh [aux|hdmi-dolby|hdmi-matrix|bt|status]"
        echo ""
        echo "  aux         → Dynamics → Dolby PLII → headphone/aux jack"
        echo "  hdmi-dolby  → Dynamics → Dolby PLII → HDMI → monitor aux"
        echo "  hdmi-matrix → Dynamics → Matrix Spatialiser → HDMI → monitor aux"
        echo "  bt          → Dynamics → Dolby PLII → Bluetooth SBC-XQ"
        echo "  status      → show current default sink and all active sinks"
        echo ""
        echo "All paths include the Dynamics Processor (compress + limit)"
        echo "for consistent volume before the spatial processing stage."
        exit 1
        ;;
esac
