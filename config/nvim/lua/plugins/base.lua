return {
  { "edkolev/tmuxline.vim" },
  { "ggandor/lightspeed.nvim" },
  { "simeji/winresizer" },
  { "tpope/vim-repeat" },
  { "tpope/vim-fugitive" },
  { "terryma/vim-multiple-cursors" },
  { "heavenshell/vim-jsdoc", build = "make install" },
  { "nvim-tree/nvim-web-devicons" },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "kylechui/nvim-surround", opts = {}, event = "VeryLazy" },
  { "moll/vim-bbye", keys = { { "<leader>q", "<cmd>:Bdelete<CR>" } } },
  { "norcalli/nvim-colorizer.lua", opts = { "*", css = { css = true, css_fn = true } } },
  -- it seems windows terminal did a great job to make clipboard yank works very well,
  -- need to test macOs later on this
  -- { "ibhagwan/smartyank.nvim" },
}
