return {
  {
    "mason-org/mason.nvim",
    -- version = "1.11.0",

    priority = 900,
    cmd = "Mason",
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    -- version = "1.32.0",
    opts = {
      automatic_enable = false,
      automatic_installation = false,
      -- only use names from the left column of
      -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
      ensure_installed = {
        "jdtls",
        "lua_ls",
        "cssls",
        "bashls",
        "yamlls",
        "jsonls",
        "html",
        "ts_ls",
        "pyright",
        "vue_ls",
        "tailwindcss",
        "rust_analyzer",
        "nginx_language_server",
        "azure_pipelines_ls",
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    opts = {
      -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim?tab=readme-ov-file#configuration
      ensure_installed = {
        "eslint_d",
        "pylint",
        "yamllint",
        "luacheck",
        "shellcheck",

        "prettier",
        "stylua",
        "black",
        "shfmt",
        "yamlfmt",

        "codelldb",
        "debugpy",
        "java-debug-adapter",

        "java-test",
      },
    },
  },
}
