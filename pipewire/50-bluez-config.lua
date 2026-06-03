bluez_monitor.properties = {
    ["bluez5.default.rate"]        = 48000,
    ["bluez5.sbc-xq.bitpool.min"]  = 64,
    ["bluez5.sbc-xq.bitpool.max"]  = 76,
    ["bluez5.a2dp.default.delay"]  = 25000,
}

-- Force SBC-XQ as preferred codec over standard SBC
bluez_monitor.rules = {
    {
        matches = {
            { { "device.name", "matches", "bluez_card.*" } },
        },
        apply_properties = {
            ["bluez5.auto-connect"] = "[ a2dp_sink ]",
            ["bluez5.hw-volume"]    = "[ a2dp_sink ]",
        },
    },
}
