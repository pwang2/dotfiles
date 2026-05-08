return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      c = { "clang_format" },
      zsh = { "shfmt" },
      sh = { "shfmt" },
      rust = { "rustfmt" },
      python = { "ruff_format" }, -- or "black" if preferred
      lua = { "stylua" },
      java = { "google_java_format" },
      toml = { "taplo" },
      typescript = { "oxfmt" },
      javascript = { "oxfmt" },
      javascriptreact = { "oxfmt" },
      typescriptreact = { "oxfmt" },
      css = { "oxfmt" },
      json = { "oxfmt" },
      jsonc = { "oxfmt" },
      vue = { "oxfmt" },
      html = { "oxfmt" },
      -- yaml = { "yamlfmt" },
    },
    format_on_save = {
      timeout_ms = 1500,
      lsp_fallback = false,
    },
  },
}
