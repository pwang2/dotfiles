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
    ---@diagnostic disable-next-line: duplicate-set-field
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
      "<leader>ad",
      function()
        require("sidekick.cli").close()
      end,
      desc = "Detach a CLI Session",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
    -- Example of a keybinding to open Claude directly
    {
      "<leader>ac",
      function()
        -- With mux.create = "split" inside tmux, Claude runs in an external tmux
        -- pane, not an nvim terminal, so cli.toggle() has nothing to show/hide.
        -- Toggle that pane ourselves: break it out to a hidden window, or join
        -- it back next to nvim's pane and focus it.
        local State = require("sidekick.cli.state")
        local pane
        for _, s in ipairs(State.get({ name = "claude", attached = true })) do
          local session = s.session --[[@as sidekick.cli.muxer.Tmux?]]
          if s.terminal == nil and session and session.tmux_pane_id then
            pane = session.tmux_pane_id
            break
          end
        end
        local me = vim.env.TMUX_PANE
        if not (pane and me) then
          return require("sidekick.cli").toggle({ name = "claude", focus = true })
        end
        local function win(p)
          return vim.trim(vim.fn.system({ "tmux", "display-message", "-p", "-t", p, "#{window_id}" }))
        end
        if win(pane) == win(me) then
          vim.fn.system({ "tmux", "break-pane", "-d", "-s", pane })
        else
          vim.fn.system({ "tmux", "join-pane", "-h", "-l", "50%", "-s", pane, "-t", me })
        end
      end,
      desc = "Sidekick Toggle Claude",
    },
  },
}
