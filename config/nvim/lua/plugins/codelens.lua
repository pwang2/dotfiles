return {
  "oribarilan/lensline.nvim",
  -- enabled = false,
  -- tag = '2.0.0', -- or: branch = 'release/2.x' for latest non-breaking updates
  branch = "release/2.x",
  event = "LspAttach",
  opts = {
    profiles = {
      {
        name = "informative",
        providers = {
          { name = "usages", enabled = true, include = { "refs", "defs", "impls" }, breakdown = true },
          { name = "diagnostics", enabled = true, min_level = "HINT" },
          { name = "complexity", enabled = true },
          {
            name = "function_length",
            enabled = true,
            event = { "BufWritePost", "TextChanged" },
            handler = function(bufnr, func_info, _, callback)
              local utils = require("lensline.utils")
              local function_lines = utils.get_function_lines(bufnr, func_info)
              local func_line_count = math.max(0, #function_lines - 1) -- Subtract 1 for signature
              callback({
                line = func_info.line,
                text = string.format("(%d loc)", func_line_count),
              })
            end,
          },
        },
        style = { render = "focused", placement = "inline" },
      },
    },
  },
}
