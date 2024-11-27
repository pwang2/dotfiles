return {
  "sindrets/diffview.nvim",
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        -- Config for changed files, and staged files in diff views.
        ---@type 'diff1_plain' |'diff2_horizontal' |'diff2_vertical' |'diff3_horizontal' |'diff3_vertical' |'diff3_mixed' |'diff4_mixed'
        layout = "diff2_horizontal",
        disable_diagnostics = false, -- Temporarily disable diagnostics for diff buffers while in the view.
        winbar_info = false, -- See |diffview-config-view.x.winbar_info|
      },
    },
    hooks = {
      diff_buf_read = function()
        -- Change local options in diff buffers
        vim.opt_local.wrap = false
        vim.opt_local.list = false
        vim.opt_local.colorcolumn = { 120 }
      end,
    },
  },
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    file_panel = {
      ["gf"] = function()
        local actions = require("diffview.actions")
        actions.goto_file()
        vim.cmd("tabclose #")
      end,
    },
    { "<leader>df", "<cmd>DiffviewOpen<cr>" },
    { "<leader>dfc", "<cmd>DiffviewClose<cr>" },
    { "<leader>dh", "<cmd>DiffviewFileHistory<cr>" },
  },
  config = function()
    vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#263834" })
    vim.api.nvim_set_hl(0, "DiffChange", { bg = "#263834" })
    vim.api.nvim_set_hl(0, "DiffText", { bg = "#335d3d", fg = "#d1d7e0" })
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#3e2e34" })
    vim.api.nvim_set_hl(0, "DiffviewDiffAddAsDelete", { bg = "#3e2e34" })
    vim.api.nvim_set_hl(0, "DiffviewDiffDelete", { bg = "#3e2e34", fg = "#cacad3" })
  end,
}

-- https://github.com/sindrets/diffview.nvim/tree/main
