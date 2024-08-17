return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			automatic_installation = false,
			ensure_installed = {
				"lua_ls",
				"cssls",
				"bashls",
				"yamlls",
				"jsonls",
				"html",
				"tsserver",
				"pyright",
				"volar",
				"tailwindcss",
				"rust_analyzer",

				--linters
				-- "eslint_d"
				-- "luacheck"
				-- "shellcheck"

				-- "formatters"
				-- "prettier"
				-- "stylua"
			},
		},
	},
}
