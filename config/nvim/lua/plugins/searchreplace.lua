return {
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    event = "BufRead",
    config = function()
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
      { "<leader>s", "<cmd>GrugFar<CR>", desc = "Replace in files" },
      {
        "<leader>sa",
        function()
          require("grug-far").open({ engine = "astgrep" })
        end,
        desc = "Replace in files (AST)",
      },
    },
    opts = {},
  },
}
