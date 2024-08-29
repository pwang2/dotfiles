return {
	"rmagatti/auto-session",
	lazy = false,
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-tree.lua",
	},
	keys = {
		-- Will use Telescope if installed or a vim.ui.select picker otherwise
		{ "<leader>wr", "<cmd>SessionSearch<CR>", desc = "Session search" },
		{ "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },
		{ "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
	},
	config = function()
		require("auto-session").setup({
			allowed_dirs = { "~/*" },
			bypass_save_filetypes = { "alpha", "dashboard" },
      silent_restore = false,
			-- Telescope.nvim integreation. defaults:
			session_lens = {
				load_on_setup = true,
				theme_conf = { border = true },
				previewer = false,
				mappings = {
					delete_session = { "i", "<C-D>" },
					alternate_session = { "i", "<C-S>" },
				},
			},
			pre_save_cmds = { "NvimTreeClose" },
			save_extra_cmds = { "NvimTreeOpen" },
			post_restore_cmds = { "NvimTreeOpen" },
		})
	end,
}
