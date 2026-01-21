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
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      -- Initialize copilot-cmp
      require("copilot_cmp").setup()

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
          -- completeopt = "menu,menuone,preview,noselect",
          completeopt = "menu,menuone,preview,preinsert,select",
          keyword_length = 1,
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "text",
            maxwidth = 70,
            minWidth = 50,
            symbol_map = {
              Copilot = "🤖 ",
            },
          }),
        },
        preselect = cmp.PreselectMode.None,
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              -- If only one completion entry, confirm it; otherwise, select next
              local entries = cmp.get_entries() or {}
              if #entries == 1 then
                cmp.confirm({ select = true })
              else
                -- TODO: change back to Insert after codecompanion fix the issue i submited
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
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            else
              fallback()
            end
          end, { "i", "s" }),
          -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          --<C-k> is used to confirm the snippet selection
          ["<C-k>"] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
          }),
        },
        sources = cmp.config.sources({
          { name = "copilot", priority = 1000 },
          { name = "nvim_lsp", priority = 900 },
          { name = "nvim_lsp_signature_help" },
          { name = "emoji" },
        }, {
          { name = "vsnip", max_item_count = 3 },
        }, {
          { name = "buffer", max_item_count = 5, priority = 10 },
        }),
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },
        window = {
          documentation = cmp.config.window.bordered(),
          completion = cmp.config.window.bordered(),
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
      -- https://github.com/zbirenbaum/copilot.lua?tab=readme-ov-file#suggestion
      cmp.event:on("menu_opened", function()
        vim.b.copilot_suggestion_hidden = true
      end)

      cmp.event:on("menu_closed", function()
        vim.b.copilot_suggestion_hidden = false
      end)

      vim.cmd([[
        hi CmpItemAbbrDeprecated  guibg=NONE     guifg=#808080 gui=strikethrough
        hi CmpItemAbbrMatch       guibg=NONE     guifg=#56d690
        hi CmpItemAbbrMatchFuzzy  guibg=NONE     guifg=#569CD6
        hi CmpItemKindVariable    guibg=NONE     guifg=#9CDCFE
        hi CmpItemKindInterface   guibg=NONE     guifg=#9CDCFE
        hi CmpItemKindText        guibg=NONE     guifg=#9CDCFE
        hi CmpItemKindFunction    guibg=NONE     guifg=#C586C0
        hi CmpItemKindMethod      guibg=NONE     guifg=#C586C0
        hi CmpItemKindKeyword     guibg=NONE     guifg=#D4D4D4
        hi CmpItemKindProperty    guibg=NONE     guifg=#D4D4D4
        hi CmpItemKindUnit        guibg=NONE     guifg=#D4D4D4
        hi CmpItemKindCopilot     guibg=NONE     guifg=#6CC644
      ]])
    end,
  },
}
