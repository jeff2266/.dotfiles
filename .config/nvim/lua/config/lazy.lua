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

-- Tab spacing
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"

-- Cursor highlighting
vim.opt.cursorline = true

-- Remap leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

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

-- Keymaps
vim.keymap.set({ "n", "x" }, "<C-d>", "<nop>")
vim.keymap.set({ "n", "x" }, "<C-u>", "<nop>")
vim.keymap.set({ "n", "x" }, "<C-j>", "<C-d>", { noremap = true })
vim.keymap.set({ "n", "x" }, "<C-k>", "<C-u>", { noremap = true })
vim.keymap.set("n", "<leader>nh", ":nohl<cr>", { desc = "File explorer" })
vim.keymap.set("n", "<leader>bb", ":bn<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<cr>", { desc = "Delete buffer" })
