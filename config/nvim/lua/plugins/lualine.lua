local get_active_lsp = function()
  local msg = "No Lsp"
  local buf_ft = vim.api.nvim_get_option_value("filetype", {})
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if next(clients) == nil then
    return msg
  end

  local lsps = {}
  for _, client in ipairs(clients) do
    ---@class vim.lsp.ClientConfig
    local config = client.config
    ---@diagnostic disable-next-line: undefined-field
    local filetypes = config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      local short_name = string.gsub(client.name, "_?ls", "")
      table.insert(lsps, short_name)
    end
  end
  return table.concat(lsps, "·")
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "ravitemer/mcphub.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_x = {
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
        },
      },
      lualine_y = {
        {
          get_active_lsp,
          icon = "",
        },
        {
          "diagnostics",
          sources = { "nvim_diagnostic", "nvim_lsp" },
          symbols = { error = "❌", warn = "🚨 ", info = "ℹ️", hint = "💡 " },
        },
      },
      lualine_z = {
        "location",
        "progress",
      },
    },
    extensions = {
      "lazy",
      "nvim-tree",
      "trouble",
    },
  },
}
