return {
	{
		"williamboman/mason.nvim",
		priority = 900,
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
				"yamllint",
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
