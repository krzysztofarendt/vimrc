require("config.lazy")

vim.g.mapleader = " "

-- Colors
vim.opt.background = "dark" -- dark | light
-- vim.cmd.colorscheme "catppuccin"
vim.cmd.colorscheme "onedark"
-- vim.cmd.colorscheme "oxocarbon"

-- Share system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Cycle
vim.keymap.set('n', '<A-Right>', '<cmd>tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<A-Left>', '<cmd>tabprev<CR>', { desc = 'Prev tab' })

-- Faster mapping resolution
vim.opt.timeout = true
vim.opt.timeoutlen = 400 -- default ~1000; try 300ms (or 200)

-- Tab -> 4 spaces
vim.cmd('set tabstop=4')
vim.cmd('set shiftwidth=4')
vim.cmd('set expandtab')

-- Comment lines
vim.keymap.set('n', '<C-c>', ':normal gcc<CR>', { desc = '[/] Toggle comment line' })
vim.keymap.set('v', '<C-c>', ':normal gcc<CR>', { desc = '[/] Toggle comment line' })
vim.keymap.set('n', '<leader>/', ':normal gcc<CR><DOWN>', { desc = '[/] Toggle comment line' })
-- <Esc> - exists visual mode.
-- :normal executes keystrokes in normal mode.
-- gv - restores selection.
-- gc - toggles comment
-- <CR> sends the command
vim.keymap.set('v', '<leader>/', '<Esc>:normal gvgc<CR>', { desc = '[/] Toggle comment block' })

-- Line numbers
vim.cmd('set number')
vim.keymap.set('n', '<F5>', ':set number!<CR>', { noremap = true })

-- Normal mode: clear search highlight
vim.keymap.set('n', '<Esc><Esc>', '<cmd>nohlsearch<CR>', { silent = true, desc = 'Clear highlights' })

-- Remove all trailing whitespace upon saving
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- Terminal
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber') -- turn off line numbers

----------------------- PLUGIN CONFIGURATION ----------------------------------

-- Hop
require 'hop'.setup()
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('n', '<leader>h', ":HopWord<CR>", { noremap = true })

-- Lualine
require('lualine').setup()

-- Oil
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Open Oil file explorer" })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- LSP configs
vim.lsp.enable('rust_analyzer')
vim.lsp.config('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = false,
            },
            check = {
                command = "clippy",
            },
        }
    }
})

vim.lsp.enable('pyright')

-- LSP keymaps (buffer-local on attach)
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspKeymaps', { clear = true }),
    callback = function(ev)
        local builtin = require('telescope.builtin')
        local buf = ev.buf
        local opts = function(desc) return { buffer = buf, silent = true, noremap = true, desc = desc } end

        -- Jumps / info
        vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts('Go to definition'))
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts('Go to declaration'))
        vim.keymap.set('n', 'gr', builtin.lsp_references, opts('References'))
        vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts('Go to implementation'))
        vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, opts('Go to type definition'))
        vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts('Hover'))

        -- Actions
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts('Rename symbol'))
        vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts('Code action'))

        -- Diagnostics
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts('Line diagnostics'))
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts('Prev diagnostic'))
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts('Next diagnostic'))
        vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist, opts('Diagnostics to loclist'))

        -- Formatting (sync/async depending on server)
        vim.keymap.set({ 'n', 'v' }, '<leader>fm', function()
            vim.lsp.buf.format({ async = true })
        end, opts('Format buffer/selection'))

        -- UI tweaks (optional)
        vim.opt.completeopt = "menuone,noselect"
        vim.opt.shortmess:append("c")

        -- Make sure omnifunc is set when LSP attaches
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("UserLspOmni", { clear = true }),
          callback = function(ev)
            vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
          end,
        })

        -- Manual trigger keys
        vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { desc = "Trigger LSP completion" })
        vim.keymap.set({ "i", "n" }, "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

    end,
})

-- nvim-treesitter ------------------------------------------------------------
require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = { "c", "cpp", "rust", "python", "lua", "markdown", "markdown_inline" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,
}
