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
      -- DEFAULT_OPTIONS = {
      -- RGB      = true;         -- #RGB hex codes
      -- RRGGBB   = true;         -- #RRGGBB hex codes
      -- names    = true;         -- "Name" codes like Blue
      -- RRGGBBAA = false;        -- #RRGGBBAA hex codes
      -- rgb_fn   = false;        -- CSS rgb() and rgba() functions
      -- hsl_fn   = false;        -- CSS hsl() and hsla() functions
      -- css      = false;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      -- css_fn   = false;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- -- Available modes: foreground, background
      -- mode     = 'background'; -- Set the display mode.
      --  }
      require("colorizer").setup({ "*", css = { css = true, css_fn = true } })
    end,
  },
}
