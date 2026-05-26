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
