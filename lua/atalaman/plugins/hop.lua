return {
  {
    "smoka7/hop.nvim",
    version = "*",
    opts = {}, -- Customize options here
    config = function()
      local hop = require("hop")
      hop.setup({
        multi_windows = false, -- Make sure it works within the same window only
      })

      -- Jump to 1-character
      vim.api.nvim_set_keymap("n", "<leader>fs", ":HopChar1<CR>", { noremap = true, silent = true })

      -- Jump to 2-character
      -- vim.api.nvim_set_keymap("n", "S", ":HopChar2<CR>", { noremap = true, silent = true })

      -- Jump to a word
      -- vim.api.nvim_set_keymap("n", "f", ":HopWord<CR>", { noremap = true, silent = true })
    end,
  },
}
