return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    -- Load at startup so the `copilot` LSP client exists for sidekick.nvim NES.
    event = "VeryLazy",
    config = function()
      require("copilot").setup({
        -- VS Code-style inline ghost text. Not a cmp source: cmp only re-queries
        -- sources on keystrokes, while ghost text refreshes on its own.
        suggestion = {
          enabled = true,
          auto_trigger = true,
          -- cmp draws its own float (not the native pum), so this flag would not
          -- hide anything anyway; show ghost text and the cmp menu together.
          hide_during_completion = false,
          debounce = 75,
          keymap = {
            accept = false, -- <Tab> is handled in cmp.lua so it can share with cmp/vsnip
            accept_word = "<M-w>",
            accept_line = "<M-q>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false },
        -- copilot.lua turns these off by default, and then no Copilot client attaches,
        -- so ghost text and NES are both missing. VS Code enables yaml.
        filetypes = { yaml = true, markdown = true },
        nes = { enabled = false }, -- NES handled by sidekick.nvim
      })
      -- Loaded after the first buffer entered, so attach to it explicitly.
      vim.schedule(function()
        vim.cmd("Copilot attach")
      end)
    end,
  },
}
