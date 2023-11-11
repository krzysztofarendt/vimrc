-- Last update: 2023.11.11
-- Author: Krzysztof Arendt

-- Package manager: Lazy
-------------------------------------------------------------------------------
-- Based on: https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- List of packages -----------------------------------------------------------
require("lazy").setup({
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"nvim-lua/plenary.nvim"},
    {"nvim-telescope/telescope.nvim", branch="0.1.x"},
    {"airblade/vim-gitgutter"},
    {"nvim-lualine/lualine.nvim"},
    {"nvim-tree/nvim-web-devicons"},
    {"nvim-tree/nvim-tree.lua"},
    {"rose-pine/neovim", name = "rose-pine"}
})

-- Color scheme ---------------------------------------------------------------
vim.cmd('colorscheme rose-pine')

-- nvim-tree setup ------------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require("nvim-tree").setup()
vim.keymap.set('n', '<F8>', ':NvimTreeToggle<CR>', {noremap = true})

-- Telescope keymaps ----------------------------------------------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Setup lualine --------------------------------------------------------------
require('lualine').setup({options = {
    theme = 'ayu_dark',
    icons_enabled = false,
    section_separators = { left = "", right = "" },
    component_separators = { left = "/", right = "/" },
}})

-- Remove all trailing whitespace upon saving ---------------------------------
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Tab -> 4 spaces
vim.cmd('set tabstop=4')
vim.cmd('set shiftwidth=4')
vim.cmd('set expandtab')

-- General keymaps ------------------------------------------------------------
vim.cmd('set number')
vim.keymap.set('n', '<F6>', ':set number!<CR>', {noremap = true})

