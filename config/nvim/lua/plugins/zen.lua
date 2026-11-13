return {
  "folke/zen-mode.nvim",
  -- enabled = false,
  -- dependencies = { "folke/twilight.nvim" },
  opts = {
    window = {
      backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
      width = 100,
      height = 0.8, -- 80%
      options = {
        signcolumn = "no", -- disable signcolumn
        number = false, -- disable number column
        relativenumber = false, -- disable relative numbers
        cursorline = false, -- disable cursorline
        cursorcolumn = false, -- disable cursor column
        foldcolumn = "0", -- disable fold column
        list = false, -- disable whitespace characters
      },
    },
    plugins = {
      options = {
        enabled = true,
        ruler = false, -- disables the ruler text in the cmd line area
        showcmd = false, -- disables the command in the last line of the screen
        -- you may turn on/off statusline in zen mode by setting 'laststatus'
        -- statusline will be shown only if 'laststatus' == 3
        laststatus = 0, -- turn off the statusline in zen mode
      },
      tmux = {
        enabled = true,
      },
      alacritty = {
        enabled = false,
        font = "20", -- font size
      },
    },
  },
  init = function()
    local saved_winborder
    vim.api.nvim_create_user_command("Zen", function()
      local opening = not require("zen-mode.view").is_open()
      if opening then
        saved_winborder = vim.o.winborder
        vim.o.winborder = "none"
      end
      vim.cmd("ZenMode")
      if not opening and saved_winborder then
        vim.o.winborder = saved_winborder
        saved_winborder = nil
      end
    end, { desc = "Toggle Zen Mode with option set first" })
  end,
  keys = {
    {
      "<leader><leader>",
      "<cmd>Zen<cr>",
      silent = true,
      desc = "Toggle Zen Mode with option set first",
    },
  },
}
