-- Helm: nvim has no built-in detection. Without this, chart templates get ft=yaml (.tpl gets smarty),
-- so the helm treesitter parser and helm_ls never attach. Only files inside a chart (Chart.yaml above) get helm.
local function helm_chart_root(path, bufnr)
  return vim.fs.root(bufnr, { "Chart.yaml" }) or vim.fs.root(path, { "Chart.yaml" })
end
vim.filetype.add({
  extension = {
    tpl = function(path, bufnr)
      return helm_chart_root(path, bufnr) and "helm" or "smarty"
    end,
  },
  pattern = {
    [".*/templates/.*%.ya?ml"] = function(path, bufnr)
      return helm_chart_root(path, bufnr) and "helm" or "yaml"
    end,
    [".*/values[^/]*%.ya?ml"] = function(path, bufnr)
      return helm_chart_root(path, bufnr) and "yaml.helm-values" or "yaml"
    end,
  },
})
