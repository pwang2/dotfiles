return {
	"gelguy/wilder.nvim",
	build = ":UpdateRemotePlugins",
	event = "CmdLineEnter",
	config = function()
		local wilder = require("wilder")
		wilder.setup({ modes = { ":", "/", "?" } })
		wilder.set_option(
			"renderer",
			wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
				pumblend = 0,
				border = "rounded",
				highlighter = wilder.basic_highlighter(),
				left = { " ", wilder.popupmenu_devicons() },
				highlights = {
					accent = wilder.make_hl(
						"WilderAccent",
						"Pmenu",
						{ { a = 1 }, { foreground = 198, background = "NONE", bold = 0 }, { foreground = "#ff4303" } }
					),
				},
			}))
		)
	end,
}
