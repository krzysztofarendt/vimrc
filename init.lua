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
    -- Lua functions (dependency for many packages)
    {"nvim-lua/plenary.nvim"},
    -- Better code highlighting
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"RRethy/vim-illuminate"},
    {"mechatroner/rainbow_csv"},
    -- LSP, autocompletion, auto-indentation
    {"Vimjas/vim-python-pep8-indent"},
    {"neovim/nvim-lspconfig"},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {"ray-x/lsp_signature.nvim",
      event = "VeryLazy",
      opts = {},
      config = function(_, opts) require'lsp_signature'.setup(opts) end
    },
    -- Folding
    {'kevinhwang91/promise-async'},
    {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'},
    -- Fuzzy finder
    {'nvim-telescope/telescope-fzf-native.nvim',
     build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
    {"nvim-telescope/telescope.nvim", branch="0.1.x"},
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
    {"nvim-tree/nvim-tree.lua"},
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
    -- Codeium
    -- {"Exafunction/codeium.vim", event = 'BufEnter' },
    -- Markdown
    {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    }
})


-- LSP config -----------------------------------------------------------------
-- Setup autocomplete from nvim-cmp
require('cmp').setup {
    sources = {
        {name = 'nvim_lsp'},
    },
}
-- Function signature hints
local cfg = {}  -- add your config here
require "lsp_signature".setup(cfg)

-- Setup language servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.clangd.setup{capabilities = capabilities}
lspconfig.pyright.setup{capabilities = capabilities}
-- lspconfig.lua_ls.setup{capabilities = capabilities}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<F3>', [[:LspRestart<CR>:echo 'LSP restarted!'<CR>]], {noremap = true})

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

-- nvim-treesitter ------------------------------------------------------------
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "python", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
}

-- nvim-ufo -------------------------------------------------------------------
vim.o.foldcolumn = '0' -- '0' means do not show fold column
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

local language_servers = require("lspconfig").util.available_servers() -- list servers manually like {'pyright', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities
        -- you can add other fields for setting up lsp server in this table
    })
end
require('ufo').setup()

-- hop config -----------------------------------------------------------------
require'hop'.setup()

local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('n', '<leader>hh',  ":HopWord<CR>", {noremap = true})

-- nvim-tree setup ------------------------------------------------------------
-- https://www.nerdfonts.com/font-downloads
-- Suggested: FiraCode Nerd Font
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require("nvim-tree").setup()
vim.keymap.set('n', '<F9>', ':NvimTreeToggle<CR>', {noremap = true})

-- oil setup ------------------------------------------------------------------
require("oil").setup()
vim.keymap.set('n', '<F8>', ':Oil<CR>', {noremap = true})

-- illuminate setup -----------------------------------------------------------
require('illuminate').configure({
    under_cursor = false,
})

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

-- Telescope settings ---------------------------------------------------------
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
local actions = require('telescope.actions')
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "ignore_case",       -- "smart_case" | "ignore_case" | "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  },
  pickers = {
    live_grep = {
      mappings = {
        i = { ["<c-f>"] = actions.to_fuzzy_refine },
      },
    },
  },
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- Grep: normal
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- Grep: fuzzy
-- vim.keymap.set('n', '<leader>fg', [[:Telescope grep_string search="" only_sort_text=true<CR>]], {})

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
