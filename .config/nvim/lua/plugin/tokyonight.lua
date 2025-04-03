return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "moon",        -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
            light_style = "night", -- The theme is used when the background is set to light
            transparent = true,
            styles = {
                floats = "transparent",
            },
            dim_inactive = true,
        }
    }
}
