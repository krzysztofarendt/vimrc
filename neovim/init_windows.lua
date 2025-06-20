-- Package manager: Lazy
-------------------------------------------------------------------------------
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
    -- Git integration
    {"airblade/vim-gitgutter"},
    {"tpope/vim-fugitive"},
    -- Terminal
    {'akinsho/toggleterm.nvim', version = "*", config = true},
    -- Status line
    {"nvim-lualine/lualine.nvim"},
    -- Navigation
    {"phaazon/hop.nvim"},
    -- File explorer
    {"stevearc/oil.nvim"},
    -- Color shemes
    {"rose-pine/neovim", name = "rose-pine"},
    {"catppuccin/nvim", name = "catppuccin", priority = 1000},
    {"chriskempson/base16-vim"},
    {"sainnhe/everforest"},
    {"folke/tokyonight.nvim"},
    {"Mofiqul/dracula.nvim"},
    -- Table formatting
    {"dhruvasagar/vim-table-mode"},
    -- Icons
    {"nvim-tree/nvim-web-devicons"},
    -- Markdown
    {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    }
})

-- hop config -----------------------------------------------------------------
require'hop'.setup()

local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('n', '<leader>hh',  ":HopWord<CR>", {noremap = true})

-- oil setup ------------------------------------------------------------------
require("oil").setup()
vim.keymap.set('n', '<F8>', ':Oil<CR>', {noremap = true})

-- toggleterm setup -----------------------------------------------------------
require("toggleterm").setup{
    -- direction="float",
    direction="horizontal",
    size = 20,
    -- float_opts = {
    --     border = "curved",
    -- },
}

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.keymap.set('n', '<F7>', [[:ToggleTerm<CR>]], {})
vim.keymap.set('t', '<F7>', [[<esc>:ToggleTerm<CR>]], {})
vim.keymap.set('v', '<F7>', [[<esc>:ToggleTerm<CR>]], {})
vim.keymap.set('t', '<F7>', [[<C-\><C-n>:ToggleTerm<CR>]], {})
vim.keymap.set('i', '<F7>', [[<esc>:ToggleTerm<CR>]], {})
vim.keymap.set('n', '<F6>', [[<esc>:ToggleTerm ]], {})

-- Setup lualine --------------------------------------------------------------
require('lualine').setup({options = {
    theme = 'dracula',
    -- theme = 'powerline',
    -- theme = 'material',
    -- theme = 'wombat',
    -- theme = 'everforest',
    icons_enabled = false,
    section_separators = { left = "", right = "" },
    component_separators = { left = "/", right = "/" },
}})

-- Remove all trailing whitespace upon saving ---------------------------------
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Tab -> 4 spaces ------------------------------------------------------------
vim.cmd('set tabstop=4')
vim.cmd('set shiftwidth=4')
vim.cmd('set expandtab')

-- General keymaps ------------------------------------------------------------
vim.cmd('set number')
vim.keymap.set('n', '<F5>', ':set number!<CR>', {noremap = true})
vim.keymap.set('n', '<leader>p', [[:echo expand('%:p')<CR>]], {noremap = true}) -- show absolute path of current file
vim.keymap.set("n", "<leader>dt", [[:r! date "+\%Y-\%m-\%d \%H:\%M:\%S" <CR>]], {noremap = true})

-- Other ----------------------------------------------------------------------
vim.opt.completeopt = { "menu" }
vim.opt.cursorline = false
vim.opt.cursorcolumn = false

-- clipboard-osc52 ------------------------------------------------------------
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

-- Show only file names in the tab line ---------------------------------------
vim.o.tabline = "%!v:lua.tabline()"

function _G.tabline()
    local s = ""
    for i = 1, vim.fn.tabpagenr('$') do
        -- Get the window number of the first window in the tab page
        local winnr = vim.fn.tabpagewinnr(i, '$')
        -- Get the buffer number associated with the window
        local bufnr = vim.fn.tabpagebuflist(i)[winnr]
        -- Get the filename associated with the buffer number
        local filename = vim.fn.bufname(bufnr)
        -- Extract the file name from the full path
        filename = vim.fn.fnamemodify(filename, ':t')
        -- Highlight the current tab
        local hl = i == vim.fn.tabpagenr() and '%#TabLineSel#' or '%#TabLine#'
        -- Add the tab label to the tabline string
        s = s .. string.format('%s %d: %s ', hl, i, filename)
    end
    return s
end

-- Table mode -----------------------------------------------------------------
vim.g.table_mode_syntax = 0  -- fixes slow Table Mode for large tables

-- Color scheme ---------------------------------------------------------------
-- vim.cmd.colorscheme('rose-pine')
-- vim.cmd.colorscheme('rose-pine-dawn')
-- vim.cmd.colorscheme('catppuccin')
-- vim.cmd.colorscheme('catppuccin-latte')
vim.cmd.colorscheme('tokyonight')
-- vim.cmd.colorscheme('dracula')
-- vim.cmd.colorscheme('dracula-soft')
-- vim.cmd.colorscheme('everforest')
-- vim.cmd.colorscheme('base16-tomorrow-night')
