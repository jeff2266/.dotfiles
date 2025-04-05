return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            {
                "nvim-telescope/telescope-file-browser.nvim",
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        config = function()
            local ts = require("telescope")
            local tsa = require("telescope.actions")
            -- local fb_actions = require "telescope._extensions.file_browser.actions"
            ts.setup {
                defaults = {
                    layout_strategy = "horizontal",
                    layout_config = {
                        prompt_position = "top",
                    },
                    sorting_strategy = "ascending",
                    path_display = { "filename_first" },
                    mappings = {
                        i = {
                            ["<C-l>"] = false,
                            ["<C-c>"] = false,
                            ["<C-x>"] = false,
                            ["<C-v>"] = false,
                            ["<C-t>"] = false,
                            ["<C-w>"] = false,
                            ["Tab"] = false,
                            ["S-Tab"] = false,
                            ["<C-q>"] = false,
                            ["<M-q>"] = false,
                            ["<C-n>"] = false,
                            ["<C-p>"] = false,

                            ["<C-j>"] = tsa.move_selection_next,
                            ["<C-k>"] = tsa.move_selection_previous,
                        }
                    },
                },
                pickers = {
                },
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                        hidden = { file_browser = true, folder_browser = true },
                        display_stat = { date = true, size = true },
                        grouped = true,
                        mappings = {
                            i = {
                            },
                            n = {
                            }
                        }
                    },
                }
            }
            ts.load_extension("fzf")
            ts.load_extension("file_browser")

            vim.keymap.set("n", "<leader>fe", ":Telescope file_browser path=%:p:h select_buffer=true<cr>",
                { desc = "File explorer" })
            vim.keymap.set("n", "<leader><leader>", ":Telescope git_files<cr>", { desc = "Find git file" })
            vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>", { desc = "Find files in current directory" })
            vim.keymap.set("n", "<leader>fs", ":Telescope live_grep<cr>",
                { desc = "Grep for string in files under current directory" })
            vim.keymap.set("n", "<leader>fc", ":Telescope grep_string<cr>",
                { desc = "Find string under cursor in current directory" })
            vim.keymap.set("n", "<leader>fb", ":Telescope buffers<cr>", { desc = "Find buffers" })
            vim.keymap.set("n", "<c-f>", ":Telescope lsp_references<cr>", { desc = "Find all references" })
        end,
    },
}
