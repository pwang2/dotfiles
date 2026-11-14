return {
  {
    "hrsh7th/nvim-cmp",
    event = { "CmdLineEnter", "InsertEnter" },
    dependencies = {
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-emoji",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local highlights = require("config.highlights")

      -- Copilot ghost text (copilot.lua suggestion module). Guarded so cmp still
      -- works if copilot.lua is not loaded yet or disabled.
      local function copilot_suggestion()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        return ok and suggestion or nil
      end
      local function ghost_visible()
        local s = copilot_suggestion()
        return s ~= nil and s.is_visible()
      end
      -- sidekick.nvim Next Edit Suggestion pending in this buffer
      local function nes_pending()
        local ok, nes = pcall(require, "sidekick.nes")
        return ok and nes.have()
      end

      local has_words_before = function()
        local unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        if col == 0 then
          return false
        end
        local text = vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})
        if not text or not text[1] then
          return false
        end
        return text[1]:match("^%s*$") == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      --use cmp.config.default() to get default config
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        completion = {
          autocomplete = {
            cmp.TriggerEvent.TextChanged,
            cmp.TriggerEvent.InsertEnter,
          },
          -- noselect: nothing is selected until you press <Tab>, so <Tab> can tell
          -- "accept ghost text" apart from "keep walking the cmp menu".
          completeopt = "menu,menuone,noselect",
          keyword_length = 1,
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "text",
            maxwidth = 70,
          }),
        },
        preselect = cmp.PreselectMode.None,
        mapping = {
          -- <Tab> priority:
          --   1. already walking the cmp menu  -> next item
          --   2. copilot ghost text visible    -> accept it
          --   3. NES pending                   -> jump to it, press again to apply
          --   4. cmp menu open                 -> confirm single entry / select next
          --   5. snippet / trigger cmp / insert a real tab
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
              -- TODO: change back to Insert after codecompanion fix the issue i submited
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif ghost_visible() then
              cmp.close()
              copilot_suggestion().accept()
            elseif nes_pending() then
              cmp.close()
              require("sidekick").nes_jump_or_apply()
            elseif cmp.visible() then
              -- If only one completion entry, confirm it; otherwise, select next
              local entries = cmp.get_entries() or {}
              if #entries == 1 then
                cmp.confirm({ select = true })
              else
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              end
            elseif vim.fn["vsnip#available"](1) == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              -- TODO: change back to Insert after codecompanion fix the issue i submited
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            else
              fallback()
            end
          end, { "i", "s" }),
          -- Walk the cmp menu without touching ghost text. Once an item is
          -- selected, <Tab> keeps walking the menu and <C-k> confirms it.
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          -- <C-e>: close cmp menu first, then dismiss ghost text on the next press.
          ["<C-e>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.abort()
            elseif ghost_visible() then
              copilot_suggestion().dismiss()
            else
              fallback()
            end
          end, { "i", "c" }),
          --<C-k> confirms the cmp entry (first one if none selected, since noselect)
          ["<C-k>"] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
          }),
        },
        sources = vim.list_extend({
          -- group_index 0 = always shown alongside other groups (lua require paths / annotations)
          { name = "lazydev", group_index = 0 },
        }, cmp.config.sources({
          { name = "nvim_lsp", priority = 900 },
          { name = "nvim_lsp_signature_help" },
          { name = "emoji" },
        }, {
          { name = "vsnip", max_item_count = 3 },
        }, {
          { name = "buffer", max_item_count = 5, priority = 10 },
        })),
        window = {
          documentation = cmp.config.window.bordered(),
          completion = cmp.config.window.bordered(),
        },
        -- Multi-line Copilot ghost text is drawn as virt_lines *below* the cursor.
        -- A menu opened below would cover everything but the first ghost line,
        -- so draw it above (cmp falls back to below when there is no room).
        -- near_cursor keeps the best match next to the cursor.
        view = {
          entries = {
            name = "custom",
            selection_order = "near_cursor",
            vertical_positioning = "above",
          },
        },
      })

      -- `?` cmdline setup.
      cmp.setup.cmdline("?", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
      local c = highlights.colors
      vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = c.cmp_deprecated, bg = "NONE", strikethrough = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = c.cmp_match, bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = c.cmp_match_fuzzy, bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = c.cmp_variable, bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = c.cmp_variable, bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = c.cmp_variable, bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = c.cmp_function, bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = c.cmp_method, bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = c.cmp_keyword, bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = c.cmp_property, bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = c.cmp_unit, bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = c.cmp_copilot, bg = "NONE" })
    end,
  },
}
