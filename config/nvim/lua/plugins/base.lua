return {
  { "edkolev/tmuxline.vim", cmd = "Tmuxline" },
  { "ggandor/lightspeed.nvim", event = "BufRead" },
  { "simeji/winresizer" },
  { "mbbill/undotree" },
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
  { "folke/todo-comments.nvim", event = "BufReadPost" },
  { "nvim-tree/nvim-tree.lua", cmd = { "NvimTreeToggle", "NvimTreeFindFile" }, opts = {} },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "Hoffs/omnisharp-extended-lsp.nvim" }, --used to make lsp gd working
  { "godlygeek/tabular" },
  {
    "nvim-pack/nvim-spectre",
    event = "InsertEnter",
    cmd = "Spectre",
    keys = { { "<leader>s", "<cmd>Spectre<CR>", desc = "Replace in files" } },
    opts = {
      line_sep_start = string.rep("~", 80),
      result_padding = "  ",
      line_sep = string.rep("~", 80),
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "scss", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      local opts = { "*", css = { css = true, css_fn = true } }
      require("colorizer").setup(opts)
    end,
  },
}
