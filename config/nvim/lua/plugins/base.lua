return {
	{ "numToStr/Comment.nvim" },
	{ "edkolev/tmuxline.vim" },
	{ "ggandor/lightspeed.nvim" },
	{ "simeji/winresizer" },
	{ "tpope/vim-repeat" },
	{ "nvim-tree/nvim-web-devicons" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{ "akinsho/bufferline.nvim", event = "BufReadPost", opts = {} },
	{ "kylechui/nvim-surround", opts = {}, event = "VeryLazy" },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{ "sindrets/diffview.nvim", cmd = { "DiffviewOpen" }, keys = { { "<leader>df", "<cmd>DiffviewOpen<cr>" } } },
	{ "windwp/nvim-ts-autotag", lazy = "true", event = { "BufReadPre", "BufNewFile" }, opts = {} },
}
