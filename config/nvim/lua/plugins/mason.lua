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
        exclude = { "yamlls", "azure_pipelines_ls", "tsgo", "copilot" },
      },
      ensure_installed = {
        "jdtls",
        "lua_ls",
        "cssls",
        "bashls",
        "yamlls",
        "jsonls",
        "omnisharp",
        "html",
        -- "ts_ls",
        "tsgo",
        "vtsls",
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
    event = "VeryLazy", --should not be lazy. as we want auto install
    opts = {
      -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim?tab=readme-ov-file#configuration
      ensure_installed = {
        "eslint_d",
        "pylint",
        "yamllint",
        "luacheck",
        "shellcheck",

        "prettier",
        "taplo",
        "stylua",
        "black",
        "shfmt",
        "yamlfmt",
        "google-java-format",

        "codelldb",
        "debugpy",
        "java-debug-adapter",
        "java-test",
        "netcoredbg",
      },
    },
  },
}
