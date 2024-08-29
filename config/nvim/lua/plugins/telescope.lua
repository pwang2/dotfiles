return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = { "Telescope" },
		keys = {
			{ "<F1>", "<cmd>Telescope<CR>", { silent = true } },
			{ "<C-p>", "<cmd>Telescope find_files<CR>", { silent = true } },
			{ "<leader>f", "<cmd>Telescope resume<CR>", { silent = true } },
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", { silent = true } },
			{ "<leader>fg", "<cmd>Telescope live_grep<CR>", { silent = true } },
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", { silent = true } },
			{ "<leader>fh", "<cmd>Telescope help_tags<CR>", { silent = true } },
			{ "<leader>fk", "<cmd>Telescope keymaps<CR>", { silent = true } },
			{ "<leader>fs", "<cmd>Telescope session-lens<CR>", { silent = true } },
		},
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
