-- Last update: 2023.11.11
-- Author: Krzysztof Arendt
--
-- Notes:
--      1)  nvim-tree requires a font with glyphs.
--          I suggest using "FiraCode Nerd Font" which
--          can be downloaded from: https://www.nerdfonts.com/font-downloads
--      2)  coq.nvim requires pyright:
--          https://microsoft.github.io/pyright/#/installation
--
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
    {"neovim/nvim-lspconfig"},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"nvim-lua/plenary.nvim"},
    {"nvim-telescope/telescope.nvim", branch="0.1.x"},
    {"airblade/vim-gitgutter"},
    {'akinsho/toggleterm.nvim', version = "*", config = true},
    {"nvim-lualine/lualine.nvim"},
    {"nvim-tree/nvim-web-devicons"},
    {"nvim-tree/nvim-tree.lua"},
    {"tpope/vim-fugitive"},
    {"dhruvasagar/vim-table-mode"},
    {"rose-pine/neovim", name = "rose-pine"}
})

-- LSP config -----------------------------------------------------------------
-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- nvim-tree setup ------------------------------------------------------------
-- https://www.nerdfonts.com/font-downloads
-- Suggested: FiraCode Nerd Font
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require("nvim-tree").setup()
vim.keymap.set('n', '<F8>', ':NvimTreeToggle<CR>', {noremap = true})

-- toggleterm setup -----------------------------------------------------------
require("toggleterm").setup{}

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.keymap.set('n', '<F7>', [[:ToggleTerm<CR>]], {})
vim.keymap.set('t', '<F7>', [[<esc>:ToggleTerm<CR>]], {})
vim.keymap.set('v', '<F7>', [[<esc>:ToggleTerm<CR>]], {})
vim.keymap.set('t', '<F7>', [[<C-\><C-n>:ToggleTerm<CR>]], {})
vim.keymap.set('i', '<F7>', [[<esc>:ToggleTerm<CR>]], {})
vim.keymap.set('n', '<F6>', [[<esc>:ToggleTerm ]], {})

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
vim.keymap.set('n', '<F5>', ':set number!<CR>', {noremap = true})

-- Color scheme ---------------------------------------------------------------
vim.cmd('colorscheme rose-pine')
