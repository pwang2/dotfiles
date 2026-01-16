local M = {}

function M.setup()
  vim.lsp.config("yamlls", {
    settings = {
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
        validate = { enable = true },
        --https://github.com/b0o/SchemaStore.nvim?tab=readme-ov-file#usage
        schemas = require("schemastore").yaml.schemas({
          ignore = {
            "Azure Pipelines",
          },
          extra = {},
        }),
      },
    },
    on_init = function(client)
      local bufname = vim.api.nvim_buf_get_name(0)
      local azure_patterns = {
        "azure%-pipelines%.yml$",
        "%.azure%-pipelines%.yml$",
        "azure%-pipelines%.yaml$",
        "%.azure%-pipelines%.yaml$",
      }
      for _, pat in ipairs(azure_patterns) do
        if bufname:match(pat) then
          client.stop()
          return
        end
      end
    end,
  })
end

return M
