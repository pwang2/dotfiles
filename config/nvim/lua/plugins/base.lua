return {
  -- Editing enhancements
  { "andymass/vim-matchup" },
  { "kylechui/nvim-surround", opts = {}, event = "VeryLazy" },
  { "mg979/vim-visual-multi" },
  { "tpope/vim-repeat" },
  { "mbbill/undotree" },
  { "simeji/winresizer" },

  -- Formatting and documentation
  { "godlygeek/tabular" },
  { "heavenshell/vim-jsdoc", build = "make install" },

  -- UI enhancements
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  { "folke/which-key.nvim", event = "VeryLazy" },
  { "sphamba/smear-cursor.nvim" },

  -- Git integration
  { "tpope/vim-fugitive" },

  -- Dependencies / Libraries
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "echasnovski/mini.nvim", version = "*" },

  -- Misc
  -- {
  --   "norcalli/nvim-colorizer.lua",
  --   ft = { "css", "scss", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  --   opts = { "*", css = { css = true, css_fn = true } },
  -- },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    version = "*",
    opts = { enable_tailwind = true },
  },
  {
    "razak17/tailwind-fold.nvim",
    ft = { "html", "svelte", "astro", "vue", "typescriptreact" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    -- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
    -- so `:ClaudeCode` and friends work on a fresh start. Without it, a keys-only
    -- spec defers loading until a <leader>a* mapping is pressed and the commands
    -- would not exist yet.
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSelectModel",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeStatus",
      "ClaudeCodeStart",
      "ClaudeCodeStop",
      "ClaudeCodeOpen",
      "ClaudeCodeClose",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
      "ClaudeCodeCloseAllDiffs",
    },
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
