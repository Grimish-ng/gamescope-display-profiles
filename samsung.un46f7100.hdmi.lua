-- Samsung UN46F7100 - HDMI 1920x1080 60Hz
-- Standard Rec.709/D65 colorimetry confirmed from EDID
-- No VRR, no HDR

gamescope.config.known_displays.samsung_un46f7100 = {
    pretty_name = "Samsung UN46F7100",
    hdr = {
        supported = false,
        force_enabled = false,
        eotf = gamescope.eotf.gamma22,
        max_content_light_level = 200,
        max_frame_average_luminance = 200,
        min_content_light_level = 0.5
    },
    colorimetry = {
        r = { x = 0.639648, y = 0.330078 },
        g = { x = 0.299805, y = 0.599609 },
        b = { x = 0.150391, y = 0.059570 },
        w = { x = 0.312500, y = 0.329102 },
    },
    dynamic_refresh_rates = { 60 },
    matches = function(display)
        debug("[samsung] vendor=" .. tostring(display.vendor)
            .. " model=" .. tostring(display.model)
            .. " product=" .. tostring(display.product)
            .. " data_string=" .. tostring(display.data_string))
        if display.vendor == "SAM"
            and display.product == 0x0A7D then
            debug("[samsung_un46f7100] Matched Samsung UN46F7100")
            return 5000
        end
        return -1
    end
}

debug("Registered Samsung UN46F7100 as a known display")
