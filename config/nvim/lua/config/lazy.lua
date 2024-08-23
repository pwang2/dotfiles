-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- This is also a good place to setup other settings (vim.opt)
vim.opt.title = true
vim.opt.wrap = true
vim.opt.splitright = true
vim.opt.expandtab = true
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.termguicolors = true
vim.opt.foldenable = false
vim.opt.shell = "zsh"
vim.opt.mouse = "a"
vim.opt.ts = 2
vim.opt.sw = 2
vim.opt.laststatus = 3
vim.opt.timeoutlen = 300
vim.opt.synmaxcol = 200
vim.opt.ttimeoutlen = 0
vim.opt.updatetime = 500
vim.opt.clipboard = "unnamedplus"
vim.opt.wildignore:append("node_modules/**,.git/**,dist/**")
vim.opt.fillchars:append("eob: ")
-- vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

-- disable these providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	ui = {
		backdrop = 0,
		border = "rounded",
	},
	diff = {
		cmd = "diffview.nvim",
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "onehalfdark" } },
	-- automatically check for plugin updates
	checker = { enabled = true, notify = false },
	change_detection = { notify = false },
})
