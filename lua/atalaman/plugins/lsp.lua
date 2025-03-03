return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x", -- Make sure we're using the latest version
    dependencies = {
      -- LSP Support
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",           -- LSP installer
      "williamboman/mason-lspconfig.nvim", -- Bridge between mason and lspconfig

      -- Autocompletion Plugins
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local lsp = require("lsp-zero")

      lsp.preset("recommended") -- Load recommended settings

      -- Mason setup to install LSP servers
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "gopls", "clangd" }, -- Ensure these LSP servers are installed
      })

      -- Configure LSP servers
      local lspconfig = require("lspconfig")
      local servers = { "pyright", "gopls", "clangd" }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }
            -- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts) -- Go to definition
            vim.keymap.set("n", "<leader>gd", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", {})
            vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, opts) -- Show documentation
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Rename symbol
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code actions
            vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
            vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
            vim.keymap.set('n', '<leader>go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
            vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
            vim.keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          end
        })
      end

      -- Autocompletion setup
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- Finalize the LSP setup
      lsp.setup()
    end,
  },
}
