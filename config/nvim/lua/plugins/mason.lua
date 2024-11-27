return {
  {
    "williamboman/mason.nvim",
    priority = 900,
    cmd = "Mason",
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = false,
      -- only use names from the left column of
      -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
      ensure_installed = {
        "lua_ls",
        "cssls",
        "bashls",
        "yamlls",
        "jsonls",
        "html",
        "ts_ls",
        "pyright",
        "volar",
        "tailwindcss",
        "rust_analyzer",
        "nginx_language_server",
        "azure_pipelines_ls",
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim?tab=readme-ov-file#configuration
      ensure_installed = {
        { "eslint_d", verison = "13.1.2", auto_update = false },
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
