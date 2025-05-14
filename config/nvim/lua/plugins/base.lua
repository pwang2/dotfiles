return {
  { "edkolev/tmuxline.vim" },
  { "ggandor/lightspeed.nvim" },
  { "simeji/winresizer" },
  { "tpope/vim-repeat" },
  { "tpope/vim-fugitive" },
  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "terryma/vim-multiple-cursors" },
  { "heavenshell/vim-jsdoc", build = "make install" },
  { "nvim-tree/nvim-web-devicons" },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "kylechui/nvim-surround", opts = {}, event = "VeryLazy" },
  { "moll/vim-bbye", keys = { { "<leader>q", "<cmd>:Bdelete<CR>" } } },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      local opts = { "*", css = { css = true, css_fn = true } }
      require("colorizer").setup(opts)
    end,
  },
  -- it seems windows terminal did a great job to make clipboard yank works very well,
  -- need to test macOs later on this
  -- { "ibhagwan/smartyank.nvim" },
}
