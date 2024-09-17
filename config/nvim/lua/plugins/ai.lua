return {
  {
    "Exafunction/codeium.vim",
    enabled = os.getenv("CODEIUM_ENABLED") == "1",
    event = "BufEnter",
    keys = {
      { "<leader>ch", "<cmd>call codeium#Chat()<cr>" },
    },
  },
}
