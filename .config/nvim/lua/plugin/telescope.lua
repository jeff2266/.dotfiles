return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'nvim-telescope/telescope-file-browser.nvim',
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
                file_browser = {
                    hijack_netrw = true,
                    hidden = { file_browser = true, folder_browser = true },
                    display_stat = { date = true, size = true, mode = false },
                    use_fd = false,
                }
            }
        }
        ts.load_extension('file_browser')
    end,
}
