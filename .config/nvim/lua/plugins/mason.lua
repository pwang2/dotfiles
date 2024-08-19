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
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"eslint_d",
				"pylint",
				"luacheck",
				"shellcheck",

				"prettier",
				"stylua",
				"black",

				"codelldb",
				"debugpy",
			},
		},
	},
}
