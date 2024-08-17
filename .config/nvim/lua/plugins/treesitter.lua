return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"c",
					"lua",
					"rust",
					"vim",
					"vimdoc",
					"typescript",
					"vue",
					"javascript",
					"css",
					"html",
				},
				sync_install = false,
				highlight = {
					enable = true,
					-- treesitter has too basic syntax highlight for html
					disable = { "html" },
				},
				indent = { enable = true },
			})
		end,
	},
}
