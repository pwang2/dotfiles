return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    "folke/snacks.nvim",
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        enabled = "tmux",
      },
    }

    local oc = require("opencode")

    vim.keymap.set({ "n", "x" }, "<leader>za", function()
      oc.ask("@this: ", { submit = true })
    end, { desc = "Ask opencode…" })

    vim.keymap.set({ "n", "x" }, "<leader>zz", function()
      oc.select()
    end, { desc = "Execute opencode action…" })

    vim.keymap.set({ "n", "t" }, "zz", function()
      oc.toggle()
    end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n" }, "<leader>af", function()
      return oc.operator("@buffer ") .. "_"
    end, { desc = "Add buffer to opencode", expr = true })

    vim.keymap.set({ "n", "x" }, "<leader>ar", function()
      return oc.operator("@this ")
    end, { desc = "Add range to opencode", expr = true })
  end,
}
