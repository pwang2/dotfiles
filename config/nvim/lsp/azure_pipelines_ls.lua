return {
  root_markers = {
    "azurepipelines-build.yml",
    "azure-pipelines.yml",
    ".azure-pipelines.yml",
    "azure-pipelines.yaml",
    ".azure-pipelines.yaml",
  },
  settings = {
    yaml = {
      schemas = {
        -- az devops invoke \
        --   --area distributedtask \
        --   --resource yamlschema \
        --   --org https://dev.azure.com/YOUR_ORG \
        --   --api-version 7.1 \
        --   > ~/.config/nvim/azure-pipelines-schema.json
        [vim.fn.expand("~/.config/nvim/azure-pipelines-schema.json")] = {
          "azurepipelines-*.y*l",
          "/azure-pipeline*.y*l",
          "/*.azure*",
          "Azure-Pipelines/**/*.y*l",
          "Pipelines/*.y*l",
        },
      },
    },
  },
}
