local M = {}

function M.setup()
  vim.lsp.config("omnisharp", { cmd = { "OmniSharp" } })
end

return M
