return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	opts = { use_diagnostic_signs = true },
	keys = {
		{
			"gr",
			"<cmd>Trouble lsp_references<cr>",
			desc = "Go to references (Trouble)",
		},
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("QuickFixCmdPost", {
			callback = function()
				vim.cmd([[Trouble qflist open]])
			end,
		})
	end,
}
