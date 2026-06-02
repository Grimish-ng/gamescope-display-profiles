-- ASUS VG32VQ1B - DP Complete Profile
-- Resolutions: 2560x1440 (72-165Hz) | 1920x1080 OC (48-165Hz)
--              2048x1152 (48-165Hz)  | 1600x900 (48-165Hz)
-- Colorimetry from ICC profile | HDR enabled | dynamic_modegen via VFP

local vg32vq1b_rates = {
     48,  49,  50,  51,  52,  53,  54,  55,  56,  57,
     58,  59,  60,  61,  62,  63,  64,  65,  66,  67,
     68,  69,  70,  71,  72,  73,  74,  75,  76,  77,
     78,  79,  80,  81,  82,  83,  84,  85,  86,  87,
     88,  89,  90,  91,  92,  93,  94,  95,  96,  97,
     98,  99, 100, 101, 102, 103, 104, 105, 106, 107,
    108, 109, 110, 111, 112, 113, 114, 115, 116, 117,
    118, 119, 120, 121, 122, 123, 124, 125, 126, 127,
    128, 129, 130, 131, 132, 133, 134, 135, 136, 137,
    138, 139, 140, 141, 142, 143, 144, 145, 146, 147,
    148, 149, 150, 151, 152, 153, 154, 155, 156, 157,
    158, 159, 160, 161, 162, 163, 164, 165
}

-- ── 2560x1440 ────────────────────────────────────────────────────────────────
-- Base: DTD3 165Hz | pc=650.030MHz | htotal=2680 | vsw=8 vback=6
-- Range: 72-165Hz | index 1=72Hz | idx = hz - 71
local vfp_1440p = {
    1915, 1869, 1824, 1780, 1737, 1696, 1656, 1616, 1578, -- 72-80Hz
    1540, 1504, 1468, 1433, 1400, 1366, 1334, 1302, 1271, -- 81-89Hz
    1241, 1211, 1182, 1154, 1126, 1099, 1073, 1047, 1021, -- 90-98Hz
     996,  971,  947,  924,  901,  878,  856,  834,  813, -- 99-107Hz
     792,  771,  751,  731,  712,  692,  674,  655,  637, -- 108-116Hz
     619,  601,  584,  567,  551,  534,  518,  502,  486, -- 117-125Hz
     471,  456,  441,  426,  412,  398,  383,  370,  356, -- 126-134Hz
     343,  329,  316,  304,  291,  278,  266,  254,  242, -- 135-143Hz
     230,  219,  207,  196,  185,  174,  163,  152,  142, -- 144-152Hz
     131,  121,  111,  101,   91,   81,   71,   62,   53, -- 153-161Hz
      43,   34,   25,   16,                               -- 162-165Hz
}

-- ── 1920x1080 OC ─────────────────────────────────────────────────────────────
-- Base: 165Hz OC | pc=362.340MHz | htotal=2000 | vsw=5 vback=10
-- vtotal: 1098(vfp=3) or 1100(vfp=5) | Range: 48-165Hz | idx = hz - 47
local vfp_1080p = {
    5, 5, 3, 5, 5, 5, 5, 3, 5, -- 48-56Hz
    5, 5, 5, 3, 5, 5, 5, 5, 3, -- 57-65Hz
    5, 5, 5, 5, 3, 5, 5, 5, 5, -- 66-74Hz
    3, 5, 5, 5, 5, 3, 5, 5, 5, -- 75-83Hz
    5, 3, 5, 5, 5, 5, 3, 5, 5, -- 84-92Hz
    5, 5, 3, 5, 5, 5, 5, 3, 5, -- 93-101Hz
    5, 5, 5, 3, 5, 5, 5, 5, 3, -- 102-110Hz
    5, 5, 5, 5, 3, 5, 5, 5, 5, -- 111-119Hz
    3, 5, 5, 5, 5, 3, 5, 5, 5, -- 120-128Hz
    5, 3, 5, 5, 5, 5, 3, 5, 5, -- 129-137Hz
    5, 5, 3, 5, 5, 5, 5, 3, 5, -- 138-146Hz
    5, 5, 5, 3, 5, 5, 5, 5, 3, -- 147-155Hz
    5, 5, 5, 5, 3, 5, 5, 5, 5, -- 156-164Hz
    3,                           -- 165Hz
}

-- ── 2048x1152 ────────────────────────────────────────────────────────────────
-- Base: 165Hz | pc=424.710MHz | htotal=2200 | vsw=5 vback=10
-- Range: 48-165Hz | idx = hz - 47
local vfp_2048x1152 = {
     8, 15,  3, 15,  8, 15,  8,  3,  8, -- 48-56Hz
     9,  8, 17,  3, 14,  8, 12,  8,  3, -- 57-65Hz
     8, 10,  8, 11,  3, 12,  8, 16,  8, -- 66-74Hz
     3,  8, 16,  8, 12,  3, 11,  8, 10, -- 75-83Hz
     8,  3,  8, 12,  8, 14,  3, 17,  8, -- 84-92Hz
     9,  8,  3,  8, 15,  8, 15,  3, 15, -- 93-101Hz
     8, 15,  8,  3,  8,  9,  8, 17,  3, -- 102-110Hz
    14,  8, 12,  8,  3,  8, 10,  8, 11, -- 111-119Hz
     3, 12,  8, 16,  8,  3,  8, 16,  8, -- 120-128Hz
    12,  3, 11,  8, 10,  8,  3,  8, 12, -- 129-137Hz
     8, 14,  3, 17,  8,  9,  8,  3,  8, -- 138-146Hz
    15,  8, 15,  3, 15,  8, 15,  8,  3, -- 147-155Hz
     8,  9,  8, 17,  3, 14,  8, 12,  8, -- 156-164Hz
     3,                                  -- 165Hz
}

-- ── 1600x900 ─────────────────────────────────────────────────────────────────
-- Base: 165Hz | pc=265.650MHz | htotal=1750 | vsw=5 vback=10
-- vtotal: 918(vfp=3) or 920(vfp=5) | Range: 48-165Hz | idx = hz - 47
local vfp_1600x900 = {
    5, 5, 5, 5, 5, 5, 5, 5, 5, -- 48-56Hz
    5, 5, 5, 3, 5, 5, 5, 5, 5, -- 57-65Hz
    5, 5, 5, 5, 5, 5, 5, 5, 5, -- 66-74Hz
    5, 5, 5, 5, 5, 3, 5, 5, 5, -- 75-83Hz
    5, 5, 5, 5, 5, 5, 5, 5, 5, -- 84-92Hz
    5, 5, 5, 5, 5, 5, 5, 3, 5, -- 93-101Hz
    5, 5, 5, 5, 5, 5, 5, 5, 5, -- 102-110Hz
    5, 5, 5, 5, 5, 5, 5, 5, 5, -- 111-119Hz
    3, 5, 5, 5, 5, 5, 5, 5, 5, -- 120-128Hz
    5, 5, 5, 5, 5, 5, 5, 5, 5, -- 129-137Hz
    5, 5, 3, 5, 5, 5, 5, 5, 5, -- 138-146Hz
    5, 5, 5, 5, 5, 5, 5, 5, 5, -- 147-155Hz
    5, 5, 5, 5, 3, 5, 5, 5, 5, -- 156-164Hz
    5,                           -- 165Hz
}

gamescope.config.known_displays.asus_vg32vq1b = {
    pretty_name = "ASUS VG32VQ1B",
    hdr = {
        supported         = true,
        force_enabled     = true,
        eotf              = gamescope.eotf.st2084,
        max_content_light_level       = 248,
        max_frame_average_luminance   = 248,
        min_content_light_level       = 0.514,
    },
    colorimetry = {
        r = { x = 0.675967, y = 0.313640 },
        g = { x = 0.305995, y = 0.631511 },
        b = { x = 0.142967, y = 0.060266 },
        w = { x = 0.345703, y = 0.358538 },
    },
    dynamic_refresh_rates = vg32vq1b_rates,
    dynamic_modegen = function(base_mode, refresh)
        local width  = base_mode.hdisplay
        local height = base_mode.vdisplay
        local vfp    = nil
        local label  = nil

        if width == 2560 and height == 1440 then
            if refresh < 72 then
                warn("[vg32vq1b] 1440p minimum is 72Hz, got " .. refresh)
                return base_mode
            end
            vfp   = vfp_1440p[refresh - 71]
            label = "2560x1440"

        elseif width == 1920 and height == 1080 then
            vfp   = vfp_1080p[refresh - 47]
            label = "1920x1080"

        elseif width == 2048 and height == 1152 then
            vfp   = vfp_2048x1152[refresh - 47]
            label = "2048x1152"

        elseif width == 1600 and height == 900 then
            vfp   = vfp_1600x900[refresh - 47]
            label = "1600x900"

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
        if display.vendor  == "AUS"
        and display.model  == "VG32VQ1B"
        and display.product == 0x32e0 then
            debug("[vg32vq1b] Matched ASUS VG32VQ1B")
            return 5000
        end
        return -1
    end,
}

debug("Registered ASUS VG32VQ1B as a known display")
