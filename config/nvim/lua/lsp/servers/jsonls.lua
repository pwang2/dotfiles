local M = {}

function M.setup()
  vim.lsp.config("jsonls", {
    filetypes = { "json", "jsonc" },
    settings = {
      json = {
        validate = { enable = true },
        schemas = require("schemastore").json.schemas(),
      },
    },
  })
end

return M
