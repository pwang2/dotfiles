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

local get_lualine_y = function()
  local defaults = {
    {
      get_active_lsp,
      icon = "🌀",
    },
    {
      "diagnostics",
      sources = { "nvim_diagnostic", "nvim_lsp" },
      symbols = { error = "❌", warn = "🚨 ", info = "ℹ️", hint = "💡 " },
    },
  }
  return defaults
end

local colors = {
  darkgray = "#16161d",
  gray = "#a8a8a8",
  innerbg = nil,
  outerbg = "#16161D",
  normal = "#6ac0ff",
  insert = "#98bb6c",
  visual = "#ffa066",
  replace = "#e46876",
  command = "#e6c384",
}
local transparent = {
  inactive = {
    a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
    b = { fg = colors.gray, bg = colors.outerbg },
    c = { fg = colors.gray, bg = colors.innerbg },
  },
  visual = {
    a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
    b = { fg = colors.gray, bg = colors.outerbg },
    c = { fg = colors.gray, bg = colors.innerbg },
  },
  replace = {
    a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
    b = { fg = colors.gray, bg = colors.outerbg },
    c = { fg = colors.gray, bg = colors.innerbg },
  },
  normal = {
    a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
    b = { fg = colors.gray, bg = colors.outerbg },
    c = { fg = colors.gray, bg = colors.innerbg },
  },
  insert = {
    a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
    b = { fg = colors.gray, bg = colors.outerbg },
    c = { fg = colors.gray, bg = colors.innerbg },
  },
  command = {
    a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
    b = { fg = colors.gray, bg = colors.outerbg },
    c = { fg = colors.gray, bg = colors.innerbg },
  },
}

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "ravitemer/mcphub.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      theme = transparent,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_x = {
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = "#ff9e64" },
        },
      },
      lualine_y = get_lualine_y(),
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
