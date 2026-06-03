-- ASUS VG32VQ1B - DP Clean Profile
-- Resolutions: 2560x1440 | 1920x1080 | 2048x1152
-- VRR: FreeSync 48-144Hz (AMD block updated)
-- Discrete rates: { 72, 96, 144 } per resolution
-- Native rated timings only, no OC
-- Colorimetry from ICC profile | HDR enabled

-- ── Rate tables ───────────────────────────────────────────────────────────────
-- Three ceiling values: Steam shows 72 / 96 / 144 as discrete options
-- FreeSync operates dynamically up to whichever ceiling is selected

local rates_1440p = { 72, 96, 144 }  -- 1440p min is 72Hz
local rates_std   = { 72, 96, 144 }  -- 1080p and 1152 can do 48 but 72 is floor

-- ── VFP tables ────────────────────────────────────────────────────────────────
-- Only three entries needed per resolution (one per discrete rate)

-- 2560x1440 | DTD4 native | pc=592.250MHz | htotal=2666 | vsw=5 vback=95
-- vfp index: [1]=72Hz [2]=96Hz [3]=144Hz
local vfp_2560x1440 = { 1545, 774, 3 }

-- 1920x1080 | DTD5 native | pc=325.060MHz | htotal=2056 | vsw=5 vback=10
-- vfp index: [1]=72Hz [2]=96Hz [3]=144Hz
local vfp_1920x1080 = { 1101, 552, 3 }

-- 2048x1152 | htotal=2400 | vtotal=1175 | vsw=5 vback=10
-- vfp index: [1]=72Hz [2]=96Hz [3]=144Hz
local vfp_2048x1152 = { 8, 8, 8 }

-- Map refresh rate to VFP table index
local function rate_to_idx(refresh)
    if refresh <= 72  then return 1 end
    if refresh <= 96  then return 2 end
    return 3  -- 144Hz
end

gamescope.config.known_displays.asus_vg32vq1b = {
    pretty_name = "ASUS VG32VQ1B",
    hdr = {
        supported                   = true,
        force_enabled               = true,
        eotf                        = gamescope.eotf.st2084,
        max_content_light_level     = 248,
        max_frame_average_luminance = 248,
        min_content_light_level     = 0.514,
    },
    colorimetry = {
        r = { x = 0.675967, y = 0.313640 },
        g = { x = 0.305995, y = 0.631511 },
        b = { x = 0.142967, y = 0.060266 },
        w = { x = 0.345703, y = 0.358538 },
    },
    dynamic_refresh_rates = rates_1440p,
    dynamic_modegen = function(base_mode, refresh)
        local width  = base_mode.hdisplay
        local height = base_mode.vdisplay
        local idx    = rate_to_idx(refresh)
        local vfp    = nil
        local label  = nil

        if width == 2560 and height == 1440 then
            if refresh < 72 then
                warn("[vg32vq1b] 1440p minimum is 72Hz, got " .. refresh)
                return base_mode
            end
            vfp   = vfp_2560x1440[idx]
            label = "2560x1440"

        elseif width == 1920 and height == 1080 then
            vfp   = vfp_1920x1080[idx]
            label = "1920x1080"

        elseif width == 2048 and height == 1152 then
            vfp   = vfp_2048x1152[idx]
            label = "2048x1152"

        else
            warn("[vg32vq1b] Unknown resolution " .. width .. "x" .. height)
            return base_mode
        end

        if vfp == nil then
            warn("[vg32vq1b] No VFP for " .. label .. " @ " .. refresh .. "Hz")
            return base_mode
        end

        debug("[vg32vq1b] Generating " .. label .. " @ " .. refresh .. "Hz vfp=" .. vfp)
        local mode = base_mode
        gamescope.modegen.adjust_front_porch(mode, vfp)
        mode.vrefresh = gamescope.modegen.calc_vrefresh(mode)
        return mode
    end,

    matches = function(display)
        if display.vendor   == "AUS"
        and display.model   == "VG32VQ1B"
        and display.product == 0x32e0 then
            debug("[vg32vq1b] Matched ASUS VG32VQ1B")
            return 5000
        end
        return -1
    end,
}

debug("Registered ASUS VG32VQ1B as a known display")
