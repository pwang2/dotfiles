return {
  "rmagatti/auto-session",
  enabled = true,
  lazy = true,
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-tree.lua",
  },
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
    allowed_dirs = { "~/*" },
    bypass_save_filetypes = { "alpha", "dashboard" },
    continue_restore_on_error = false,
    post_restore_cmds = { "NvimTreeOpen" },
    pre_save_cmds = { "NvimTreeClose" },
    save_extra_cmds = { "NvimTreeOpen" },
    session_lens = {
      load_on_setup = true,
      mappings = {
        alternate_session = { "i", "<C-S>" },
        delete_session = { "i", "<C-D>" },
      },
      previewer = false,
      theme_conf = {
        border = true,
      },
    },
  },
}
