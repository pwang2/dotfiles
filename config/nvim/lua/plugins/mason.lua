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
			-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim?tab=readme-ov-file#configuration
			ensure_installed = {
				{ "eslint_d", verison = "13.1.2", auto_update = false },
				"pylint",
				"luacheck",
				"shellcheck",

				"prettier",
				"stylua",
				"black",
				"shfmt",

				"codelldb",
				"debugpy",
			},
		},
	},
}
