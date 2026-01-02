return {
  {
    "ggandor/leap.nvim",
    event = "BufRead",
    config = function()
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    event = "InsertEnter",
    cmd = "Spectre",
    keys = {
      { "<leader>s", "<cmd>Spectre<CR>", desc = "Replace in files" },
    },
    opts = {
      line_sep_start = string.rep("~", 80),
      result_padding = "  ",
      line_sep = string.rep("~", 80),
    },
  },
}
