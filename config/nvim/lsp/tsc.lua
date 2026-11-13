return {
  -- Automatically uses 'tsc --lsp --stdio' behind the scenes
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", ".git" },
  -- capabilities (incl. disabled dynamic file watching) come from vim.lsp.config("*") in plugins/lsp.lua
}
