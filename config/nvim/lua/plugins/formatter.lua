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
      typescript = { "prettier" },
      javascript = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      vue = { "prettier" },
      html = { "prettier" },
      -- yaml = { "yamlfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = false,
    },
  },
}
