return {
  {
    "mason-org/mason.nvim",
    lazy = true,
    priority = 900,
    cmd = "Mason",
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = false,
      automatic_installation = false,
      -- use name in mason-registry
      ensure_installed = {
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
      },
    },
  },
}
