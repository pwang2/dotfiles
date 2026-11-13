-- Single source of truth for "is this an Azure Pipelines file".
-- azure_pipelines_ls attaches only to these files; yamlls skips them.
local M = {}

-- Lua patterns matched against the full buffer path.
-- Keep in sync with `schema_globs` below.
local patterns = {
  "/azurepipelines%-[^/]*%.ya?ml$", -- azurepipelines-build.yml
  "/%.?azure%-pipeline[^/]*%.ya?ml$", -- (.)azure-pipelines.yml / .yaml
  "/[^/]*%.azure[^/]*%.ya?ml$", -- foo.azure.yml
  "/Azure%-Pipelines/.+%.ya?ml$", -- Azure-Pipelines/**/*.yml
  "/Pipelines/[^/]+%.ya?ml$", -- Pipelines/*.yml
}

-- Globs handed to azure_pipelines_ls for schema association.
M.schema_globs = {
  "azurepipelines-*.y*l",
  "/azure-pipeline*.y*l",
  "/.azure-pipeline*.y*l",
  "/*.azure*",
  "Azure-Pipelines/**/*.y*l",
  "Pipelines/*.y*l",
}

M.root_markers = {
  "azurepipelines-build.yml",
  "azure-pipelines.yml",
  ".azure-pipelines.yml",
  "azure-pipelines.yaml",
  ".azure-pipelines.yaml",
  ".git",
}

---@param name string full buffer path
---@return boolean
function M.is_azure_file(name)
  for _, pat in ipairs(patterns) do
    if name:match(pat) then
      return true
    end
  end
  return false
end

return M
