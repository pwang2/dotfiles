return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
  },
  keys = {
    { "<leader>fn", "<cmd>Telescope notify<cr>" },
  },
  config = function()
    ---@class NoiceConfig
    local opts = {
      -- this make cmdline and popupmenu not dismissed
      views = {
        --   popup = {
        --     size = {
        --       width = "80",
        --       height = "auto",
        --       max_width = 160,
        --     },
        --   },
        -- cmdline_popup = {
        --   border = {
        --     padding = { 1, 2 },
        --   },
        -- },
      },

      routes = {
        {
          ---@class NoiceFilter
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "%d fewer lines" },
              { find = "%d more lines" },
            },
          },
          view = "mini",
          opts = {
            timeout = 2000,
          },
        },

        {
          --https://github.com/folke/trouble.nvim/issues/329
          ---@class NoiceFilter
          filter = {
            event = "notify",
            find = "Cursor position outside buffer",
          },
          opts = { skip = true },
        },
        {
          ---@class NoiceFilter
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
        {
          ---@class NoiceFilter
          filter = {
            event = "notify",
            find = "No ESLint configuration found in ",
          },
          opts = { skip = true },
        },
        {
          view = "mini",
          ---@type NoiceFilter
          filter = {
            event = "notify",
            find = "Failed to run formatter",
          },
        },
        {
          filter = { event = "msg_show" },
          view = "notify",
          opts = {
            level = "info",
            skip = false,
            replace = false,
          },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        --NOTE: DISABLE THIS AS IT IS TOO NOISY
        enabled = true, -- enables the Noice messages UI
        view = "notify", -- default view for messages
        view_error = "notify", -- view for errors
        view_warn = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
    }
    require("noice").setup(opts)
    require("notify").setup({
      background_colour = "#000000",
    })
  end,
}
