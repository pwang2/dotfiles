return {
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = { "CmdLineEnter", "InsertEnter" },
		dependencies = {
			"onsails/lspkind-nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			local has_words_before = function()
				--luacheck: ignore unpack
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local feedkey = function(key, mode)
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				formatting = {
					format = function(entry, item)
						item.kind = lspkind.symbolic(item.kind, { mode = "symbol_text" })
						item.menu = entry.source.name
						item.abbr = string.sub(item.abbr, 1, 80)
						return item
					end,
				},
				-- preselect = cmp.PreselectMode.Item,
				mapping = {
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
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
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
						elseif vim.fn["vsnip#jumpable"](-1) == 1 then
							feedkey("<Plug>(vsnip-jump-prev)", "")
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
					["<C-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
					["<C-k>"] = cmp.mapping.confirm({ select = true }),
					["<C-j>"] = cmp.mapping(function(fallback)
						cmp.mapping.abort()
						-- local copilot_keys = vim.fn["copilot#Accept"]()
						-- if copilot_keys ~= "" then
						-- 	vim.api.nvim_feedkeys(copilot_keys, "i", true)
						-- else
						fallback()
						-- end
					end),
				},
				sources = cmp.config.sources({
					{ name = "vsnip", max_item_count = 3, priority = 50 },
					{ name = "nvim_lsp", max_item_count = 10, priority = 40 },
					{ name = "nvim_lsp_signature_help" },
					-- { name = "buffer", max_item_count = 5, priority = 10 },
					{ name = "emoji" },
				}, {
					-- { name = "buffer" },
				}),
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				window = {
					documentation = {
						border = "rounded",
						winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
					},
					completion = {
						border = "rounded",
						winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
					},
				},
				experimental = {
					ghost_text = true,
				},
			})

			-- `?` cmdline setup.
			cmp.setup.cmdline("?", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
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
      ]])
		end,
	},
}
