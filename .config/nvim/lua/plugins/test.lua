return {
	"nvim-neotest/neotest",
	ft = { "javascript", "typescript" },
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"marilari88/neotest-vitest",
		"rouge8/neotest-rust",
	},
	keys = {
		{
			"<leader>ts",
			"<cmd>lua require('neotest').summary.toggle()<cr>",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-vitest")({
					filter_dir = function(name)
						return name ~= "node_modules"
					end,
				}),
			},
		})
	end,
}
