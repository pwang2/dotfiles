return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = "VeryLazy", -- vim.lsp.enable() also attaches to already-loaded buffers
    dependencies = {
      {
        "mason-org/mason.nvim",
        priority = 900,
        cmd = "Mason",
        -- setup() prepends mason/bin to PATH; linters/formatters need it before VeryLazy
        event = { "BufReadPre", "BufNewFile" },
        opts = {
          ui = { border = "rounded" },
        },
      },
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_enable = {
        exclude = {
          "vtsls",
        },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- Loaded on VeryLazy, i.e. after VimEnter, so the plugin's own VimEnter
    -- autocmd never fires. Trigger the install check manually in config.
    event = "VeryLazy",
    config = function(_, opts)
      require("mason-tool-installer").setup(opts)
      require("mason-tool-installer").run_on_start()
    end,
    opts = {
      -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim?tab=readme-ov-file#configuration
      ensure_installed = {
        -- LSP servers (mason package names)
        "lua-language-server",
        "css-lsp",
        "bash-language-server",
        "yaml-language-server",
        "json-lsp",
        "omnisharp",
        "html-lsp",
        "tsc",
        "helm-ls",
        -- "vtsls",
        -- "vue-language-server",
        "basedpyright",
        "tailwindcss-language-server",
        "rust-analyzer",
        "nginx-language-server",
        "azure-pipelines-language-server",

        "eslint_d",
        "ruff", -- linter (nvim-lint) + formatter (conform ruff_format)
        "yamllint",
        "luacheck",

        "prettier", -- conform: ts/js/css/json/vue/html
        "taplo",
        "stylua",
        "shfmt",
        "yamlfmt",
        "kulala-fmt",

        "codelldb",
        "debugpy",
        "netcoredbg",
      },
    },
  },
}
