return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    init = function()
      vim.o.foldenable = true
      vim.o.foldcolumn = "auto"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
    end,
    opts = {
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
    },
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
    },
  },
}
