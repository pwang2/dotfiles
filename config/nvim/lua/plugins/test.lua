return {
  "nvim-neotest/neotest",
  ft = { "javascript", "typescript" },
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
    "rouge8/neotest-rust",
  },
  keys = {
    {
      "<leader>ts",
      "<cmd>lua require('neotest').summary.toggle()<cr>",
    },
  },
  config = function()
    require("neotest").setup({
      icons = {
        -- child_indent = "│",
        -- child_prefix = "├",
        -- collapsed = "─",
        -- expanded = "╮",
        -- failed = "",
        -- final_child_indent = " ",
        -- final_child_prefix = "╰",
        -- non_collapsible = "─",
        child_indent = " ",
        child_prefix = " ",
        collapsed = "─",
        expanded = "🞃",
        failed = "",
        final_child_indent = " ",
        final_child_prefix = " ",
        non_collapsible = " ",
        notify = "",
        passed = "",
        running = "",
        running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
        skipped = "",
        unknown = "",
        watching = "",
      },
      adapters = {
        require("neotest-vitest")({
          filter_dir = function(name)
            return name ~= "node_modules"
          end,
        }),
      },
    })
  end,
}
