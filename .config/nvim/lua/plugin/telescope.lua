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
            local fb_actions = require "telescope._extensions.file_browser.actions"
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
                            ["<C-c>"] = false,
                            ["<C-x>"] = false,
                            ["<C-v>"] = false,
                            ["<C-t>"] = false,
                            ["<C-d>"] = false,
                            ["<C-u>"] = false,
                            ["<C-w>"] = false,
                            ["<C-q>"] = false,
                            ["<C-l>"] = false,
                            -- ["<C-/>"] = false,
                            ["<C-_>"] = false,
                            ["<M-q>"] = false,

                            ["<C-j>"] = tsa.move_selection_next,
                            ["<C-k>"] = tsa.move_selection_previous,
                            ["<C-n>"] = tsa.preview_scrolling_down,
                            ["<C-p>"] = tsa.preview_scrolling_up,
                        },
                        n = {
                            ["<C-x>"] = false,
                            ["<C-v>"] = false,
                            ["<C-t>"] = false,
                            ["<C-d>"] = false,
                            ["<C-u>"] = false,
                            ["<C-q>"] = false,
                            ["<M-q>"] = false,

                            ["<C-j>"] = tsa.move_selection_next,
                            ["<C-k>"] = tsa.move_selection_previous,
                            ["<C-n>"] = tsa.preview_scrolling_down,
                            ["<C-p>"] = tsa.preview_scrolling_up,
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
                                ["<A-c>"] = false,
                                -- ["<S-CR>"] = fb_actions.create_from_prompt,
                                ["<S-CR>"] = false,
                                -- ["<A-r>"] = fb_actions.rename,
                                ["<C-y>r"] = fb_actions.rename,
                                ["<C-y>m"] = fb_actions.move,
                                -- ["<A-y>"] = fb_actions.copy,
                                ["<C-y>y"] = fb_actions.copy,
                                -- ["<A-d>"] = fb_actions.remove,
                                ["<C-d>"] = fb_actions.remove,
                                -- ["<C-o>"] = fb_actions.open,
                                -- ["<C-g>"] = fb_actions.goto_parent_dir,
                                ["<C-h>"] = fb_actions.goto_parent_dir,
                                -- ["<C-e>"] = fb_actions.goto_home_dir,
                                -- ["<C-w>"] = fb_actions.goto_cwd,
                                -- ["<C-t>"] = fb_actions.change_cwd,
                                -- ["<C-f>"] = fb_actions.toggle_browser,
                                -- ["<C-h>"] = fb_actions.toggle_hidden,
                                -- ["<C-s>"] = fb_actions.toggle_all,
                                -- ["<bs>"] = fb_actions.backspace,
                                -- [Path.path.sep] = fb_actions.path_separator,
                                -- ["<A-n>"] = fb_actions.create,
                                ["<C-n>"] = fb_actions.create,
                            },
                            n = {
                                -- ["c"] = fb_actions.create,
                                -- ["r"] = fb_actions.rename,
                                -- ["m"] = fb_actions.move,
                                -- ["y"] = fb_actions.copy,
                                -- ["d"] = fb_actions.remove,
                                -- ["o"] = fb_actions.open,
                                -- ["g"] = fb_actions.goto_parent_dir,
                                -- ["e"] = fb_actions.goto_home_dir,
                                -- ["w"] = fb_actions.goto_cwd,
                                -- ["t"] = fb_actions.change_cwd,
                                -- ["f"] = fb_actions.toggle_browser,
                                -- ["h"] = fb_actions.toggle_hidden,
                                -- ["s"] = fb_actions.toggle_all,
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
            vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics<cr>", { desc = "List diagnostics" })

            vim.keymap.set("n", "grr", ":Telescope lsp_references<cr>", { desc = "Find all references" })
        end,
    },
}
