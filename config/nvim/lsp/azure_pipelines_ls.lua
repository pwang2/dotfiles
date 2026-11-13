local azure = require("config.azure")

return {
  -- Attach only to Azure Pipelines files (yamlls owns every other yaml file).
  root_dir = function(bufnr, on_dir)
    local name = vim.api.nvim_buf_get_name(bufnr)
    if not azure.is_azure_file(name) then
      return
    end
    on_dir(vim.fs.root(bufnr, azure.root_markers) or vim.fs.dirname(name))
  end,
  settings = {
    yaml = {
      schemas = {
        -- az devops invoke \
        --   --area distributedtask \
        --   --resource yamlschema \
        --   --org https://dev.azure.com/YOUR_ORG \
        --   --api-version 7.1 \
        --   > ~/.config/nvim/azure-pipelines-schema.json
        [vim.fn.expand("~/.config/nvim/azure-pipelines-schema.json")] = azure.schema_globs,
      },
    },
  },
}
