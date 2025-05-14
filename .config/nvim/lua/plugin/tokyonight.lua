return {
    {
        "folke/tokyonight.nvim",
        cond = not (vim.g.vscode ~= nil),
        lazy = false,
        priority = 1000,
        config = function()
            local tn = require("tokyonight")
            tn.setup {
                -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
                style = "night",
                transparent = true,
                styles = {
                    floats = "transparent",
                },
                dim_inactive = true,
            }
            vim.cmd("colorscheme tokyonight")
        end,

    }
}
