return {
	{ "numToStr/Comment.nvim" },
	{ "edkolev/tmuxline.vim" },
	{ "ggandor/lightspeed.nvim" },
	{ "simeji/winresizer" },
	{ "norcalli/nvim-colorizer.lua" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "akinsho/bufferline.nvim", event = "BufReadPost", opts = {} },
	{ "kylechui/nvim-surround", opts = {}, event = "VeryLazy" },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{ "sindrets/diffview.nvim", cmd = { "DiffviewOpen" }, keys = { { "<leader>df", "<cmd>DiffviewOpen<cr>" } } },
	{ "windwp/nvim-ts-autotag", lazy = "true", event = { "BufReadPre", "BufNewFile" }, opts = {} },
}
