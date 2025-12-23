return {
  "folke/sidekick.nvim",
  enabled = false,
  event = "VeryLazy",
  opts = {
    nes = {
      enabled = true,
    },
    -- add any options here
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
        create = "split",
      },
    },
    copilot = {
      -- track copilot's status with `didChangeStatus`
      status = {
        enabled = true,
        level = vim.log.levels.WARN,
        -- set to vim.log.levels.OFF to disable notifications
        -- level = vim.log.levels.OFF,
      },
    },
  },
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle CLI",
    },
  },
}
