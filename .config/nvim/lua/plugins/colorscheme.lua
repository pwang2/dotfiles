return {
	{
		"sonph/onehalf",
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local lazypath = vim.fn.stdpath("data") .. "/lazy"
			vim.opt.runtimepath:append(lazypath .. "/onehalf/vim")
			vim.cmd([[colorscheme onehalfdark]])
		end,
	},
}
