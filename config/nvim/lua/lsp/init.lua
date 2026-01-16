local M = {}

function M.setup()
  local capabilities = require("lsp.capabilities").capabilities
  local on_attach = require("lsp.on_attach").on_attach

  -- Configure default LSP settings for all servers
  vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- Setup individual server configurations
  require("lsp.servers").setup()
end

return M
