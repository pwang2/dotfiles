return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	cmd = { "NvimTreeOpen", "NvimTreeToggle" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>t", "<cmd>:NvimTreeToggle<cr>", desc = "toggle nvim-tree" },
	},
	config = function()
		local opts = {
			git = {
				enable = false,
			},
			actions = {
				open_file = {
					resize_window = true,
				},
			},
			view = {
				width = {
					max = 36,
				},
			},
			live_filter = {
				prefix = " : ",
				always_show_folders = true, -- Turn into false from true by default
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				local function opts(desc)
					return {
						desc = "nvim-tree: " .. desc,
						buffer = bufnr,
						noremap = true,
						silent = true,
						nowait = true,
					}
				end

				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.del("n", "<C-e>", { buffer = bufnr })
				vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: V Split"))
				vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open: H Split"))
				vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
			end,
		}
		require("nvim-tree").setup(opts)
	end,
}
