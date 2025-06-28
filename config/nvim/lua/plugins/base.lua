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
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "kylechui/nvim-surround", opts = {}, event = "VeryLazy" },
  { "moll/vim-bbye", keys = { { "<leader>q", "<cmd>:Bdelete<CR>", desc = "Delete Buffer" } } },
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
  { "folke/which-key.nvim", event = "VeryLazy" },
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  { "folke/todo-comments.nvim", event = "BufReadPost" },
  { "nvim-tree/nvim-tree.lua", cmd = { "NvimTreeToggle", "NvimTreeFindFile" }, opts = {} },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "scss", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      local opts = { "*", css = { css = true, css_fn = true } }
      require("colorizer").setup(opts)
    end,
  },
  --used to make lsp gd working
  { "Hoffs/omnisharp-extended-lsp.nvim" },
  -- it seems windows terminal did a great job to make clipboard yank works very well,
  -- need to test macOs later on this
  -- { "ibhagwan/smartyank.nvim" },
}
