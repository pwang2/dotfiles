return {
  "rmagatti/auto-session",
  -- enabled = false,
  lazy = false,
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    -- comment out to avoid conflect with workspace shortcut
    -- { "<leader>wr", "<cmd>SessionSearch<CR>", desc = "Session search" },
    -- { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },
    -- { "<leader>s", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
  },

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@class AutoSession.Config

  config = function()
    local opts = {
      suppressed_dirs = { "~/" },
      allowed_dirs = { "~/dotfiles", "~/emd-mono/UI" },
      bypass_save_filetypes = { "alpha", "dashboard", "codecompanion" },
    }
    require("auto-session").setup(opts)
  end,
}
