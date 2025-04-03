-- Sync + with unnamed register on unfocus
vim.api.nvim_create_autocmd({ "FocusGained" }, {
    pattern = { "*" },
    command = [[call setreg("@", getreg("+"))]],
})

-- Sync + with unnamed register on unfocus
vim.api.nvim_create_autocmd({ "FocusLost" }, {
    pattern = { "*" },
    command = [[call setreg("+", getreg("@"))]],
})

-- vim.api.nvim_create_autocmd("User", {
--     pattern = "*",
--     once = true,
--     callback = function()
        -- local telescope = require("telescope")
        -- telescope.load_extension "file_browser"
        -- local netrw_bufname
        --
        -- -- clear FileExplorer appropriately to prevent netrw from launching on folders
        -- -- netrw may or may not be loaded before telescope-file-browser config
        -- -- conceptual credits to nvim-tree
        -- pcall(vim.api.nvim_clear_autocmds, { group = "FileExplorer" })
        -- vim.api.nvim_create_autocmd("VimEnter", {
        --     pattern = "*",
        --     once = true,
        --     callback = function()
        --         pcall(vim.api.nvim_clear_autocmds, { group = "FileExplorer" })
        --     end,
        -- })
        -- vim.api.nvim_create_autocmd("BufEnter", {
        --     group = vim.api.nvim_create_augroup("telescope-file-browser.nvim", { clear = true }),
        --     pattern = "*",
        --     callback = function()
        --         vim.schedule(function()
        --             if vim.bo[0].filetype == "netrw" then
        --                 return
        --             end
        --             local bufname = vim.api.nvim_buf_get_name(0)
        --             if vim.fn.isdirectory(bufname) == 0 then
        --                 _, netrw_bufname = pcall(vim.fn.expand, "#:p:h")
        --                 return
        --             end
        --
        --             -- prevents reopening of file-browser if exiting without selecting a file
        --             if netrw_bufname == bufname then
        --                 netrw_bufname = nil
        --                 return
        --             else
        --                 netrw_bufname = bufname
        --             end
        --
        --             -- ensure no buffers remain with the directory name
        --             vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")
        --
        --             require("telescope").extensions.file_browser.file_browser {
        --                 cwd = vim.fn.expand "%:p:h",
        --             }
        --         end)
        --     end,
        --     desc = "telescope-file-browser.nvim replacement for netrw",
        -- })
--     end,
-- })
