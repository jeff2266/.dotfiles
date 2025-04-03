return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
    },
    extensions = {
        file_browser = {
            grouped = true,
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
            },
        },
    },
    config = function()
        local ts = require('telescope')
        ts.setup {
            defaults = {
                layout_strategy = 'horizontal',
                layout_config = {
                    prompt_position = 'top',
                },
                sorting_strategy = 'ascending',
                path_display = { "filename_first" },
                mappings = {
                },
            },
            pickers = {
            },
            extensions = {
            }
        }
        ts.load_extension('file_browser')
    end,
}
