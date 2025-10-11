require("config.lazy")

vim.g.mapleader = " "
vim.cmd.colorscheme "catppuccin"

-- Tab -> 4 spaces
vim.cmd('set tabstop=4')
vim.cmd('set shiftwidth=4')
vim.cmd('set expandtab')

-- Remove all trailing whitespace upon saving
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

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
        enable = false;
      }
    }
  }
})

vim.lsp.enable('pyright')
vim.lsp.enable('lua_ls')

-- LSP keymaps (buffer-local on attach)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspKeymaps', { clear = true }),
  callback = function(ev)
    local builtin = require('telescope.builtin')
    local buf = ev.buf
    local opts = function(desc) return { buffer = buf, silent = true, noremap = true, desc = desc } end

    -- Jumps / info
    vim.keymap.set('n', 'gd', builtin.lsp_definitions,       opts('Go to definition'))
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,        opts('Go to declaration'))
    vim.keymap.set('n', 'gr', builtin.lsp_references,         opts('References'))
    vim.keymap.set('n', 'gi', builtin.lsp_implementations,    opts('Go to implementation'))
    vim.keymap.set('n', 'gt', builtin.lsp_type_definitions,   opts('Go to type definition'))
    vim.keymap.set('n', '<leader>k',  vim.lsp.buf.hover,              opts('Hover'))

    -- Actions
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename,     opts('Rename symbol'))
    vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts('Code action'))

    -- Diagnostics
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float,      opts('Line diagnostics'))
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,       opts('Prev diagnostic'))
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next,       opts('Next diagnostic'))
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts('Diagnostics to loclist'))

    -- Formatting (sync/async depending on server)
    vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts('Format buffer/selection'))

    -- (Optional) toggle inlay hints (Neovim 0.10+)
    if vim.lsp.inlay_hint then
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint(buf, not vim.lsp.inlay_hint.is_enabled(buf))
      end, opts('Toggle inlay hints'))
    end
  end,
})


