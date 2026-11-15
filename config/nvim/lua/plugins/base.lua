return {
  -- Editing enhancements
  { "andymass/vim-matchup", opt = {} },
  { "kylechui/nvim-surround", opts = {}, event = "VeryLazy" },
  { "mg979/vim-visual-multi", opt = {} },
  { "tpope/vim-repeat", opt = {} },
  { "simeji/winresizer", opt = {} },
  { "godlygeek/tabular", opt = {} },

  -- UI enhancements
  { "folke/which-key.nvim", event = "VeryLazy", opt = {} },
  { "sphamba/smear-cursor.nvim", opts = {} },

  -- Git integration
  { "tpope/vim-fugitive", opt = {} },
  { "lewis6991/gitsigns.nvim", opts = {} },

  -- Dependencies / Libraries
  { "nvim-lua/plenary.nvim", opt = {} },
  { "nvim-tree/nvim-web-devicons", opt = {} },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", opt = {} },
  { "echasnovski/mini.nvim", version = "*", opt = {} },
  { "brenoprata10/nvim-highlight-colors", event = "VeryLazy", opts = { enable_tailwind = true } },
  {
    "razak17/tailwind-fold.nvim",
    ft = { "html", "svelte", "astro", "vue", "typescriptreact" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}
