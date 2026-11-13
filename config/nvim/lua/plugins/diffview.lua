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
    keymaps = {
      file_panel = {
        {
          "n",
          "gf",
          function()
            require("diffview.actions").goto_file()
            vim.cmd("tabclose #")
          end,
          { desc = "Open file and close Diffview" },
        },
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
    { "<leader>df", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>dfc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    { "<leader>dfh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    { "<leader>dfH", "<cmd>DiffviewFileHistory<cr>", desc = "File History (All Files)" },
    { "<leader>dfs", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle File Panel" },
  },
  config = function()
    local highlights = require("config.highlights")
    local c = highlights.colors
    vim.api.nvim_set_hl(0, "DiffAdd", { bg = c.diffview_diff_add_bg })
    vim.api.nvim_set_hl(0, "DiffChange", { bg = c.diffview_diff_change_bg })
    vim.api.nvim_set_hl(0, "DiffText", { bg = c.diffview_diff_text_bg, fg = c.diffview_diff_text_fg })
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.diffview_diff_delete_bg })
    vim.api.nvim_set_hl(0, "DiffviewDiffAddAsDelete", { bg = c.diffview_diff_delete_bg })
    vim.api.nvim_set_hl(0, "DiffviewDiffDelete", { bg = c.diffview_diff_delete_bg, fg = c.diffview_diff_delete_fg })
  end,
}

-- https://github.com/sindrets/diffview.nvim/tree/main
