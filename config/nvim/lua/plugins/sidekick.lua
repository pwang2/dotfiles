return {
  "folke/sidekick.nvim",
  -- enabled = false,
  event = "VeryLazy",
  opts = {
    nes = {
      enabled = true,
      debounce = 300,
      trigger = {
        -- Defaults only request NES when leaving insert mode or after a normal-mode
        -- edit. VS Code also asks after each typing pause, so add TextChangedI
        -- (sidekick maps it to Copilot's didChange, so the buffer version is synced).
        -- Each keystroke still clears the old NES first (clear.events below).
        -- "ModeChanged i:n" is handled in config() below, see there.
        events = { "TextChanged", "TextChangedI", "User SidekickNesDone" },
      },
      clear = {
        events = { "TextChangedI", "InsertEnter" },
        -- Handled in config() below: the default also clears on the <Esc> that
        -- leaves insert mode, which throws away the NES you just got.
        esc = false,
      },
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
  config = function(_, opts)
    require("sidekick").setup(opts)
    local nes = require("sidekick.nes")
    local group = vim.api.nvim_create_augroup("user_sidekick_nes", { clear = true })

    -- Workaround (copilot-language-server 1.56x): NES edits come with the generic
    -- `github.copilot.didAcceptCompletionItem` command. Its handler only checks
    -- the ghost-text cache, so the server never records the NES as accepted. On the
    -- next request it marks the applied NES as *rejected*, drops its queued
    -- follow-up edits (e.g. `this.z = z` after the constructor), and lowers NES
    -- aggressiveness. Send the NES-specific accept command instead (same id).
    local apply = nes.apply
    nes.apply = function(...)
      for _, edit in ipairs(nes.get(vim.api.nvim_get_current_buf())) do
        if edit.command and edit.command.command == "github.copilot.didAcceptCompletionItem" then
          edit.command = vim.tbl_extend("force", edit.command, {
            command = "github.copilot.didAcceptNextEditSuggestionItem",
          })
        end
      end
      return apply(...)
    end

    -- Leaving insert mode: keep a NES that is already shown. Clearing it makes the
    -- Copilot server log it as rejected ("cached edit was previously rejected"),
    -- so it is never offered again. Only ask again when nothing is shown. In
    -- normal mode the cursor is not at end of line, so the server skips its fixed
    -- ~2 s end-of-line debounce and the reply comes faster.
    vim.api.nvim_create_autocmd("ModeChanged", {
      group = group,
      pattern = "i:n",
      callback = function()
        vim.schedule(function()
          if not nes.have() then
            nes.update()
          end
        end)
      end,
    })

    -- <Esc> in normal mode still dismisses the NES. vim.on_key runs before the key
    -- is processed, so the <Esc> that leaves insert mode still sees mode "i".
    local esc = vim.keycode("<Esc>")
    vim.on_key(function(_, typed)
      if typed == esc and vim.api.nvim_get_mode().mode == "n" then
        nes.clear()
      end
    end, vim.api.nvim_create_namespace("user_sidekick_nes_esc"))
  end,
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
      "<leader>at",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle CLI",
    },
  },
}
