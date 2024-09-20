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
    { "<leader>df", "<cmd>DiffviewOpen<cr>" },
    { "<leader>dh", "<cmd>DiffviewFileHistory<cr>" },
  },
  config = function()
    vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0c4532" })
    vim.api.nvim_set_hl(0, "DiffChange", { bg = "#188a64" })
    vim.api.nvim_set_hl(0, "DiffText", { bg = "#188a64", fg = "#61afef" })
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#4c232d", fg = "#e8b9b8" })
    vim.api.nvim_set_hl(0, "DiffviewDiffAddAsDelete", { bg = "#431313" })
    vim.api.nvim_set_hl(0, "DiffviewDiffDelete", { bg = "none", fg = "#141414" })
  end,
}

-- https://github.com/sindrets/diffview.nvim/tree/main
