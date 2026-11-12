return {
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      validate = { enable = true },
      schemas = require("schemastore").json.schemas({
        -- Explicitly ignore the Resume schema if it's causing global issues
        ignore = { "Applicant Profile Protocol" },
      }),
    },
  },
}
