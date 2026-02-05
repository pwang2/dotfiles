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
    ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
