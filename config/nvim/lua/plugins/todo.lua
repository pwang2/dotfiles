return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- https://github.com/folke/todo-comments.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		{ "<leader>td", "<cmd>TodoTelescope<cr>" },
	},
}
