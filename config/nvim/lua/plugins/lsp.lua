return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"b0o/schemastore.nvim",
			"mason-org/mason-registry",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local borderStyle = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
			local lspconfig = require("lspconfig")
			local lspConfigUtil = require("lspconfig.util")
			require("lspconfig.ui.windows").default_options.border = borderStyle

			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			---@diagnostic disable-next-line: duplicate-set-field
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = borderStyle
				opts.max_width = opts.max_width or 80
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end

			local on_attach = function(_, bufnr)
				local bkm = vim.api.nvim_buf_set_keymap
				local km = vim.api.nvim_set_keymap
				local kb_opts = { noremap = true, silent = true }
				local mkmp = function(key, cmd)
					vim.lsp.util.make_floating_popup_options(80, 20, {})
					bkm(bufnr, "n", key, "<cmd>lua vim.lsp.buf." .. cmd .. "()<CR>", kb_opts)
				end

				mkmp("gD", "declaration")
				mkmp("gd", "definition")
				mkmp("K", "hover")
				mkmp("gi", "implementation")
				mkmp("<space>k", "signature_help")
				mkmp("<space>D", "type_definition")
				mkmp("<space>rn", "rename")
				mkmp("<space>ca", "code_action")
				-- mkmp("<space>f", "format")
				-- mkmp("<localleader>f", "format") -- use formatter.nvim
				-- mkmp('gr', 'references') -- use trouble gr

				km("n", "<space>e", "<cmd>lua vim.diagnostic.open_float({width = 80})<CR>", kb_opts)
				km("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", kb_opts)
				km("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", kb_opts)
				km("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", kb_opts)
				km("n", "gv", "<cmd>:vsplit | lua vim.lsp.buf.definition()<CR>", kb_opts)
			end

			-- local default_capabilities = vim.lsp.protocol.make_client_capabilities()
			-- need this to allow jsonls to complete from JSON scheme
			-- default_capabilities.textDocument.completion.completionItem.snippetSupport = true

			-- https://github.com/hrsh7th/cmp-nvim-lsp/issues/38#issuecomment-1815265121
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)
			lspConfigUtil.default_config = vim.tbl_extend("force", lspConfigUtil.default_config, {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.rust_analyzer.setup({})

			lspconfig.gopls.setup({})

			lspconfig.pyright.setup({})

			lspconfig.yamlls.setup({
				settings = {
					yaml = {
						--https://github.com/b0o/SchemaStore.nvim?tab=readme-ov-file#usage
						schemas = require("schemastore").yaml.schemas({
							extra = {
								{
									description = "kubernetes config",
									fileMatch = "deployment/**/*.yaml",
									name = "kind",
									url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.28.0-standalone/all.json",
								},
							},
						}),
					},
				},
			})

			lspconfig.jsonls.setup({
				filetypes = { "json", "jsonc" },
				settings = {
					json = {
						validate = { enable = true },
						schemas = require("schemastore").json.schemas(),
					},
				},
			})

			lspconfig.tailwindcss.setup({
				filetypes = { "vue", "html", "css", "javascript", "typescript" },
			})

			lspconfig.lua_ls.setup({
				settings = { Lua = { diagnostics = { globals = { "vim", "hs", "spoon" } } } },
				on_init = function(client)
					local path = client.workspace_folders[1].name
					local uv = require("luv")
					if uv.fs_stat(path .. "/.luarc.json") or uv.fs_stat(path .. "/.luarc.jsonc") then
						return
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					})
				end,
			})

			lspconfig.nginx_language_server.setup({})

			lspconfig.bashls.setup({})

			-- https://github.com/vuejs/language-tools?tab=readme-ov-file#community-integration
			local mason_registry = require("mason-registry")
			local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
				.. "/node_modules/@vue/language-server"

			lspconfig.tsserver.setup({
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
			})

			lspconfig.volar.setup({
				init_options = {
					vue = {
						hybridMode = false,
					},
				},
			})
		end,
	},
}
