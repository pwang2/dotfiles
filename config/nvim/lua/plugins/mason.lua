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
    lazy = "VeryLazy",
    opts = {
      -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim?tab=readme-ov-file#configuration
      ensure_installed = {
        "eslint_d",
        "pylint",
        "yamllint",
        "luacheck",
        "shellcheck",

        "oxfmt",
        "taplo",
        "stylua",
        "black",
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
