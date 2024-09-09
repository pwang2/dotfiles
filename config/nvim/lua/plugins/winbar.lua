return {
	"utilyre/barbecue.nvim",
	enabled = false,
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	opts = {
		exclude_filetypes = { "NvimTree", "toggleterm" },
	},
}
