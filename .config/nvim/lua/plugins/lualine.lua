local get_active_lsp = function()
	local msg = "No Lsp"
	local buf_ft = vim.api.nvim_get_option_value("filetype", {})
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if next(clients) == nil then
		return msg
	end

	local lsps = ""
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			lsps = lsps .. "|" .. client.name
		end
	end
	return string.sub(lsps, 2)
end

return {
	"nvim-lualine/lualine.nvim",
	opts = {
		sections = {
			lualine_y = {
				{
					get_active_lsp,
					icon = "",
				},
				{
					"diagnostics",
					sources = { "nvim_diagnostic", "nvim_lsp" },
					symbols = { error = "🆇 ", warn = "🔴 ", info = "❕", hint = " " },
				},
			},

			lualine_z = {
				"location",
				"progress",
			},
		},
		extensions = {
			"lazy",
			"nvim-tree",
			"trouble",
		},
	},
}
