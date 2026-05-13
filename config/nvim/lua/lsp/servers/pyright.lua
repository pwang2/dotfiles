local M = {}

function M.setup()
  vim.lsp.config("pyright", {
    on_attach = require("lsp.on_attach").on_attach, -- explicit, don't rely on "*"
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
        },
      },
    },
  })
end

return M
