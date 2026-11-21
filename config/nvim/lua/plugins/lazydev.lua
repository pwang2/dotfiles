return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = function()
      return {
        library = {
          "lazy.nvim",
        },
      }
    end,
  },
}
