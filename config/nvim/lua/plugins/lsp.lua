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
		local lspsetup = require("utils.lspsetup")

		lspsetup.setup(lspconfigutil)

		lspconfig.rust_analyzer.setup({})
		lspconfig.gopls.setup({})
		lspconfig.pyright.setup({})
		lspconfig.tailwindcss.setup({ filetypes = { "vue", "html", "css", "javascript", "typescript" } })
		lspconfig.nginx_language_server.setup({})
		lspconfig.bashls.setup({})
		lspconfig.cssls.setup({})
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
