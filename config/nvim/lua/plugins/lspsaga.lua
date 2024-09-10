return {
	"nvimdev/lspsaga.nvim",
	event = { "LspAttach" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	keys = {
		{ "<leader>ca", "<cmd>Lspsaga code_action<cr>" },
		{ "<leader>p", "<cmd>Lspsaga peek_definition<cr>" },
		{ "K", "<cmd>Lspsaga hover_doc<cr>" },
	},
	config = function()
		require("lspsaga").setup({
			ui = {
				code_action = "💡",
			},
			symbol_in_winbar = {
				enable = false,
			},
			hover = {
				max_width = 0.4,
			},
			outline = {
				win_position = "right",
			},
		})
	end,
}
