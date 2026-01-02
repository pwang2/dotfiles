return {
  { "edkolev/tmuxline.vim", cmd = "Tmuxline" },
  { "simeji/winresizer" },
  { "mbbill/undotree" },
  { "andymass/vim-matchup" },
  { "tpope/vim-repeat" },
  { "tpope/vim-fugitive" },
  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "terryma/vim-multiple-cursors" },
  { "heavenshell/vim-jsdoc", build = "make install" },
  { "nvim-tree/nvim-web-devicons" },
  { "echasnovski/mini.nvim", version = "*" },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "kylechui/nvim-surround", opts = {}, event = "VeryLazy" },
  { "folke/which-key.nvim", event = "VeryLazy" },
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  -- { "folke/todo-comments.nvim", event = "BufReadPost" },  //native support now see :h commenting
  { "nvim-tree/nvim-tree.lua", cmd = { "NvimTreeToggle", "NvimTreeFindFile" }, opts = {} },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "Hoffs/omnisharp-extended-lsp.nvim" }, --used to make lsp gd working
  { "godlygeek/tabular" },
  { "sphamba/smear-cursor.nvim", opts = {} },
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "scss", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      local opts = { "*", css = { css = true, css_fn = true } }
      require("colorizer").setup(opts)
    end,
  },
  {
    "razak17/tailwind-fold.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
  },
}
