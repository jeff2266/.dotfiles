-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Appearance
vim.cmd.colorscheme("habamax")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

-- Keymaps
-- vim.keymap.set("n", "<c-b>", ":NvimTreeToggle<cr>", { desc = "Toggle explorer" })
vim.keymap.set("n", "<c-b>", ":Telescope file_browser<cr>", { desc = "Toggle explorer" })
vim.keymap.set("n", "<leader><leader>", ":Telescope git_files<cr>", { desc = "Find git file" })
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>", { desc = "Find file" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<cr>", { desc = "Grep current directory" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<cr>", { desc = "Find buffers" })

vim.keymap.set("n", "<c-f>", ":Telescope lsp_references<cr>", { desc = "Find all references" })
vim.keymap.set("n", "<c-k>f", ":lua vim.lsp.buf.format()<cr>", { desc = "Format file" })

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

-- Wsl clipboard configuration
vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
        ["+"] = "clip.exe",
    },
    paste = {
        ["+"] =
        'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
}

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugin" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- automatically check for plugin updates
    checker = { enabled = true },
    install = { colorscheme = nil },
})

local telescope = require("telescope")
telescope.load_extension "file_browser"
local netrw_bufname

-- clear FileExplorer appropriately to prevent netrw from launching on folders
-- netrw may or may not be loaded before telescope-file-browser config
pcall(vim.api.nvim_clear_autocmds, { group = "FileExplorer" })
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    once = true,
    callback = function()
        pcall(vim.api.nvim_clear_autocmds, { group = "FileExplorer" })
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("telescope-file-browser.nvim", { clear = true }),
    pattern = "*",
    callback = function()
        vim.schedule(function()
            if vim.bo[0].filetype == "netrw" then
                return
            end
            local bufname = vim.api.nvim_buf_get_name(0)
            if vim.fn.isdirectory(bufname) == 0 then
                _, netrw_bufname = pcall(vim.fn.expand, "#:p:h")
                return
            end

            -- prevents reopening of file-browser if exiting without selecting a file
            if netrw_bufname == bufname then
                netrw_bufname = nil
                return
            else
                netrw_bufname = bufname
            end

            -- ensure no buffers remain with the directory name
            vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = 0 })

            require("telescope").extensions.file_browser.file_browser {
                cwd = vim.fn.expand "%:p:h",
            }
        end)
    end,
    desc = "telescope-file-browser.nvim replacement for netrw",
})
