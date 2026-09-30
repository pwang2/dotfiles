local M = {}

function M.setup()
  vim.lsp.config("azure_pipelines_ls", {
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
          ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
            "azurepipelines-*.y*l",
            "/azure-pipeline*.y*l",
            "/*.azure*",
            "Azure-Pipelines/**/*.y*l",
            "Pipelines/*.y*l",
          },
        },
      },
    },
  })
end

return M
