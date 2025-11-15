return {
  "ojroques/nvim-osc52",
  config = function()
    local osc52 = require("osc52")

    osc52.setup {}

    local function copy(lines, _)
      osc52.copy(table.concat(lines, "\n"))
    end

    local function paste()
      return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
    end

    vim.g.clipboard = {
      name = "osc52",
      copy = { ["+"] = copy, ["*"] = copy },
      paste = { ["+"] = paste, ["*"] = paste },
    }

    -- Optional: integrate with y/Y/yy
    vim.keymap.set("n", "y", "y<cmd>lua require('osc52').copy_register('+')<CR>", { noremap = true, silent = true })
    vim.keymap.set("v", "y", "y<cmd>lua require('osc52').copy_register('+')<CR>", { noremap = true, silent = true })
  end,
}
