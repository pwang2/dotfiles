return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = { "Telescope" },
		config = function()
			local trouble = require("trouble.sources.telescope")
			local troublemaker = trouble.open

			require("telescope").setup({
				defaults = {
					mappings = {
						i = { ["<leader>t"] = troublemaker },
						n = { ["<leader>t"] = troublemaker },
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						file_ignore_patterns = { ".git", "node_modules" },
					},
				},
			})
		end,
	},
}
