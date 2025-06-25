return {
  "rmagatti/auto-session",
  -- enabled = false,
  lazy = false,
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { "<leader>wr", "<cmd>SessionSearch<CR>", desc = "Session search" },
    { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },
    { "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
  },

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@class AutoSession.Config
  opts = {
    suppressed_dirs = { "~/" },
    allowed_dirs = { "~/dotfiles", "~/emd-mono" },
    bypass_save_filetypes = { "alpha", "dashboard", "codecompanion" },
  },
}
