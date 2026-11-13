return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "mason-org/mason.nvim",
        priority = 900,
        cmd = "Mason",
        opts = {
          ui = { border = "rounded" },
        },
      },
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_enable = {
        exclude = {
          "copilot",
          "vtsls",
        },
      },
      ensure_installed = {
        "lua_ls",
        "cssls",
        "bashls",
        "yamlls",
        "jsonls",
        "omnisharp",
        "html",
        "tsc",
        "helm_ls",
        -- "vtsls",
        -- "vue_ls",
        "basedpyright",
        "tailwindcss",
        "rust_analyzer",
        "nginx_language_server",
        "azure_pipelines_ls",
        "copilot",
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- comment following line out after the first time setup
    event = "VeryLazy",
    opts = {
      -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim?tab=readme-ov-file#configuration
      ensure_installed = {
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
