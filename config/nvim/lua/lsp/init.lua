local M = {}

function M.setup()
  local capabilities = require("lsp.capabilities").capabilities
  local on_attach = require("lsp.on_attach").on_attach

  -- Configure default LSP settings for all servers
  vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- NOTE: vim.lsp.config("*") not propagating on_attach —
  -- This is a known rough edge with the Neovim 0.11 API + mason-lspconfig. The on_attach in vim.lsp.config("*") should merge correctly, but if there's a version mismatch between mason-org/mason-lspconfig.nvim and Neovim, it might silently drop it.
  -- The safest fix is to explicitly add on_attach in pyright.lua (lsp/servers/pyright.lua:3):
  -- function M.setup()
  --   vim.lsp.config("pyright", {
  --     on_attach = require("lsp.on_attach").on_attach,  -- explicit, don't rely on "*"
  --     settings = { ... },
  --   })
  -- end

  -- Setup individual server configurations
  require("lsp.servers").setup()
end

return M
