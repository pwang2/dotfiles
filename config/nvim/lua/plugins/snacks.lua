return {
  "folke/snacks.nvim",
  -- event = "VeryLazy",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    input = {
      enabled = true,
      config = function()
        local snacks = require("snacks")
        vim.ui.input = snacks.input.input
      end,
    },
    picker = {
      enabled = true,
      config = function()
        local snacks = require("snacks")
        vim.ui.select = snacks.picker.select
      end,
    },
    terminal = {
      enabled = true,
    },
    bufdelete = {
      enabled = true,
    },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { section = "recent_files", cwd = true, indent = 0, gap = 1 },
        { section = "session", indent = 0, gap = 1 },
        -- { icon = "  ", title = "Projects", section = "projects", indent = 2, padding = { 2, 0 } },
        { section = "keys", gap = 1 },
        { section = "startup" },
      },
    },
    scratch = { enabled = true },
    -- scroll = { enabled = true },
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
    {
      "<leader>.",
      function()
        require("snacks").scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        require("snacks").scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
  },
}
