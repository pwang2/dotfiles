return {
	"voldikss/vim-floaterm",
	cmd = { "FloatermToggle" },
	keys = {
		{ "<C-t>", ":FloatermToggle<CR>", noremap = true, silent = true },
	},
	config = function()
		vim.api.nvim_set_keymap("t", "<C-t>", "<C-\\><C-n>:FloatermToggle<CR>", { noremap = true, silent = true })
	end,
}

--Bizzare, have to use this way to make the open and close both working
