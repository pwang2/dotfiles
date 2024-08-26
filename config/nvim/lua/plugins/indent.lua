return {
	"nvimdev/indentmini.nvim",
	enabled = false,
	event = "BufEnter",
	config = function()
		require("indentmini").setup()
	end,
}
