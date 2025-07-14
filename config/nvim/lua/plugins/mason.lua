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
      automatic_enable = false,
      automatic_installation = false,
      -- use name in mason-registry
      --only accepts LSP servers and - more importantly - only accepts`nvim-lspconfig` server names
      ensure_installed = {
        "jdtls",
        "lua_ls",
        "cssls",
        "bashls",
        "yamlls",
        "jsonls",
        "omnisharp",
        "html",
        "ts_ls",
        "pyright",
        -- "vtsls",
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
        "stylua",
        "black",
        "shfmt",
        "yamlfmt",
        "google-java-format",

        "codelldb",
        "debugpy",
      },
    },
  },
}
