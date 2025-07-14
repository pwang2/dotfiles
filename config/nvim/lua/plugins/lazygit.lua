return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
  config = function()
    require("telescope").load_extension("lazygit")
    vim.api.nvim_set_hl(0, "LazyGitBorder", { fg = "#585858" })
  end,
}
