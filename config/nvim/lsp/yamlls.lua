local azure_patterns = {
  "azure%-pipelines%.yml$",
  "azure%-pipelines%.yaml$",
}

return {
  -- Skip azure pipeline files (azure_pipelines_ls owns them) and Helm templates.
  -- Default root_dir from nvim-lspconfig is replaced, so provide root markers here.
  root_dir = function(bufnr, on_dir)
    local name = vim.api.nvim_buf_get_name(bufnr)
    for _, pat in ipairs(azure_patterns) do
      if name:match(pat) then
        return
      end
    end
    -- Skip Helm chart templates: Go templating is not valid YAML.
    local chart_root = vim.fs.root(bufnr, { "Chart.yaml" })
    if chart_root and vim.startswith(name, chart_root .. "/templates/") then
      return
    end
    on_dir(vim.fs.root(bufnr, { ".git" }) or vim.fn.getcwd())
  end,
  settings = {
    yaml = {
      schemaStore = {
        -- Disable built-in schemaStore to use SchemaStore.nvim with `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      validate = { enable = true },
      -- https://github.com/b0o/SchemaStore.nvim?tab=readme-ov-file#usage
      schemas = require("schemastore").yaml.schemas({
        ignore = { "Azure Pipelines" },
        extra = {},
      }),
    },
  },
}
