return {
  "folke/snacks.nvim",
  event = "VeryLazy",
  opts = {
    bufdelete = {
      enabled = true,
    },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { icon = "  ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 0 } },
        { icon = "  ", title = "Projects", section = "projects", indent = 2, padding = { 2, 0 } },
        { section = "keys", gap = 1 },
        { section = "startup" },
      },
    },
    scroll = {
      enabled = true,
    },
  },
  keys = {
    {
      "<leader>q",
      function()
        require("snacks").bufdelete()
      end,
      desc = "Delete buffer",
    },

    {
      "<leader>cab",
      function()
        require("snacks").bufdelete.other()
      end,
      desc = "Delete other buffers",
    },

    {
      "<leader>qa",
      function()
        require("snacks").bufdelete.all()
      end,
      desc = "Delete all buffers",
    },
  },
}
