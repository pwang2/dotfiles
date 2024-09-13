return {
	"sindrets/diffview.nvim",
	opts = {
		enhanced_diff_hl = true,
	},
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	keys = {
		{ "<leader>df", "<cmd>DiffviewOpen<cr>" },
		{ "<leader>dh", "<cmd>DiffviewFileHistory<cr>" },
	},
}
