return {
  {
    "navarasu/onedark.nvim",
    enabled = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      style = "darker", --  'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      toggle_style_key = "<leader>dd", -- keybind to toggle theme style.
    },
  },
  {
    "sonph/onehalf",
    enabled = true,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      -- Simple time-based theme detection to avoid flash
      -- Use light mode during daytime (6 AM to 6 PM), dark mode at night
      local hour = tonumber(os.date("%H"))
      local is_daytime = hour >= 6 and hour < 18
      vim.o.background = is_daytime and "light" or "dark"

      -- Airline theme will be set dynamically based on background
      vim.g.airline_theme = vim.o.background == "dark" and "onehalfdark" or "onehalflight"
    end,
    config = function()
      local lazypath = vim.fn.stdpath("data") .. "/lazy"
      vim.opt.runtimepath:append(lazypath .. "/onehalf/vim")
      -- Set initial colorscheme based on background we detected
      -- auto-dark-mode will update it later if needed
      local colorscheme = vim.o.background == "dark" and "onehalfdark" or "onehalflight"
      vim.cmd("colorscheme " .. colorscheme)
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    enabled = true,
    lazy = false,
    priority = 1100, -- load early to detect background before colorscheme
    opts = {
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.g.airline_theme = "onehalfdark"
        vim.cmd("colorscheme onehalfdark")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.g.airline_theme = "onehalflight"
        vim.cmd("colorscheme onehalflight")
      end,
      update_interval = 1000,
      fallback = "dark",
    },
  },
}
