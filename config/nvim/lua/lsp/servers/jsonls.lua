local M = {}

function M.setup()
  vim.lsp.config("jsonls", {
    filetypes = { "json", "jsonc" },
    settings = {
      json = {
        validate = { enable = true },
        schemas = require("schemastore").json.schemas({
          -- 2. Explicitly ignore the Resume schema if it's causing global issues
          ignore = { "Applicant Profile Protocol" },
        }),
      },
    },
  })
end

return M
