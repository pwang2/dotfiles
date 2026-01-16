local M = {}

-- https://github.com/hrsh7th/cmp-nvim-lsp/issues/38#issuecomment-1815265121
---@class lsp.ClientCapabilities
M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities(),
  -- Some LSP servers also expect to be informed about the extended client capabilities.
  require("lsp-file-operations").default_capabilities()
)

return M
