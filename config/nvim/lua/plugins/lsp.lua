local function lsp_setup(lspconfigutil)
	local borderStyle = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
	require("lspconfig.ui.windows").default_options.border = borderStyle

	-- https://neovim.io/doc/user/lsp.html#lsp-handlers
	local origin_ofp = vim.lsp.util.open_floating_preview
	local patch_float_window = function(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = borderStyle
		opts.max_width = opts.max_width or 80
		return origin_ofp(contents, syntax, opts, ...)
	end
	vim.lsp.util.open_floating_preview = patch_float_window

	local on_attach = function(_, bufnr)
		local opts = { noremap = true, silent = true, buffer = bufnr }

		local mk = function(key, cmd)
			vim.keymap.set("n", key, cmd, opts)
		end

		mk("gd", vim.lsp.buf.definition)
		mk("gv", function()
			vim.cmd([[vsplit]])
			vim.lsp.buf.definition()
		end)
		mk("gD", vim.lsp.buf.declaration)
		mk("gi", vim.lsp.buf.implementation)
		mk("<leader>k", vim.lsp.buf.signature_help)
		mk("<leader>D", vim.lsp.buf.type_definition)
		mk("<leader>rn", vim.lsp.buf.rename)
		mk("K", vim.lsp.buf.hover)
		mk("<space>e", vim.diagnostic.open_float)
		mk("<leader>q", vim.diagnostic.setloclist)
		mk("[d", vim.diagnostic.goto_prev)
		mk("]d", vim.diagnostic.goto_next)
		vim.keymap.set("n", "<leader>ca", require("fastaction").code_action, opts)
		vim.keymap.set("v", "<leader>ca", require("fastaction").range_code_action, opts)

		--mk("<leader>ca", vim.lsp.code_action) --use fastaction.code_action
		--mk("<leader>f", vim.lsp.format) --use formatter.nvim
		--mk("<leader>f", vim.lsp.format) --use formatter.nvim
		--mk('gr', vim.lsp.references)  --use trouble gr
	end

	-- https://github.com/hrsh7th/cmp-nvim-lsp/issues/38#issuecomment-1815265121
	lspconfigutil.default_config = vim.tbl_extend("force", lspconfigutil.default_config, {
		on_attach = on_attach,
		capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		),
	})
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
		"b0o/schemastore.nvim",
		"mason-org/mason-registry",
		"Chaitanyabsprip/fastaction.nvim",
	},
	keys = {
		{ "<leader>rr", "<cmd>LspRestart<cr>", { silent = true } },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local lspconfigutil = require("lspconfig.util")

		lsp_setup(lspconfigutil)

		lspconfig.rust_analyzer.setup({})
		lspconfig.gopls.setup({})
		lspconfig.pyright.setup({})
		lspconfig.tailwindcss.setup({ filetypes = { "vue", "html", "css", "javascript", "typescript" } })
		lspconfig.nginx_language_server.setup({})
		lspconfig.bashls.setup({})
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

		-- https://github.com/vuejs/language-tools?tab=readme-ov-file#community-integration
		lspconfig.ts_ls.setup({
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = vim.fn.stdpath("data")
							.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
						languages = { "vue" },
					},
				},
			},
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
		})

		-- "Hybrid" mode, volar exclusively manages the CSS/HTML sections.
		lspconfig.volar.setup({
			init_options = {
				vue = {
					hybridmode = true,
				},
			},
		})
	end,
}
