return {
  { "edkolev/tmuxline.vim" },
  { "ggandor/lightspeed.nvim" },
  { "simeji/winresizer" },
  { "tpope/vim-repeat" },
  { "terryma/vim-multiple-cursors" },
  { "nvim-tree/nvim-web-devicons" },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "kylechui/nvim-surround", opts = {}, event = "VeryLazy" },
  { "moll/vim-bbye", keys = { { "<leader>q", "<cmd>:Bdelete<CR>" } } },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*", css = { css = true, css_fn = true } })
    end,
  },
}
