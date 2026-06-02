# Gamescope Display Profiles

Custom gamescope Lua display scripts and EDID binaries for:

## ASUS VG32VQ1B (DisplayPort)
- **Resolutions:** 2560x1440 | 1920x1080 | 2048x1152 | 1600x900
- **Refresh:** 48-165Hz VRR (1440p: 72-165Hz)
- **1080p OC:** 165Hz (native is 144Hz)
- **HDR:** Enabled, colorimetry from ICC profile
- **Files:** `asus.vg32vq1b.dp.lua`, `vg32vq1b.bin`

## Samsung UN46F7100 (HDMI)
- **Resolution:** 1920x1080 @ 60Hz
- **HDR:** Not supported
- **Colorimetry:** Standard Rec.709/D65
- **File:** `samsung.un46f7100.hdmi.lua`

## Installation
```bash
# Lua scripts
cp *.lua ~/.config/gamescope/scripts/00-gamescope/displays/

# EDID binary (kernel override)
sudo cp vg32vq1b.bin /lib/firmware/edid/
# Add to kernel params: drm.edid_firmware=DP-1:edid/vg32vq1b.bin
# Add to /etc/mkinitcpio.conf FILES=(/lib/firmware/edid/vg32vq1b.bin)
sudo mkinitcpio -P
```

## Pipewire Audio Configuration

Sample rate: 48kHz default, 44100/48000 allowed (96kHz removed)
Quantum: 512

Dolby Pro Logic II filter chain routes audio through headphone jack
to VIZIO SB2820n-E0 soundbar via aux cable.

Installation:
  cp pipewire/pipewire.conf ~/.config/pipewire/
  mkdir -p ~/.config/pipewire/pipewire.conf.d/
  cp pipewire/pipewire.conf.d/99-dolby-plii.conf ~/.config/pipewire/pipewire.conf.d/
  mkdir -p ~/.config/pipewire/pipewire-pulse.conf.d/
  cp pipewire/pipewire-pulse.conf.d/99-default-sink.conf ~/.config/pipewire/pipewire-pulse.conf.d/
  systemctl --user restart pipewire pipewire-pulse wireplumber
