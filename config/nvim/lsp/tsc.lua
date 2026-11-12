return {
  -- Automatically uses 'tsc --lsp --stdio' behind the scenes
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", ".git" },

  capabilities = (function()
    local caps = vim.lsp.protocol.make_client_capabilities()
    caps.workspace.didChangeWatchedFiles.dynamicRegistration = false
    return caps
  end)(),
}
