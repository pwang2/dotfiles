local M = {}

-- List of server modules to setup
local servers = {
  "rust_analyzer",
  "omnisharp",
  "cssls",
  "azure_pipelines_ls",
  "yamlls",
  "jsonls",
  "lua_ls",
  "vtsls",
  -- jdtls is handled separately by nvim-jdtls plugin
}

function M.setup()
  for _, server in ipairs(servers) do
    require("lsp.servers." .. server).setup()
  end
end

return M
