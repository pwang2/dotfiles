return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = { "Telescope" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-symbols.nvim",
    },
    keys = {
      { "<F1>", "<cmd>Telescope<CR>", { silent = true } },
      { "<C-p>", "<cmd>Telescope find_files<CR>", { silent = true } },
      { "<leader>f", "<cmd>Telescope resume<CR>", { silent = true } },
      { "<leader>ff", "<cmd>Telescope find_files<CR>", { silent = true } },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", { silent = true } },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", { silent = true } },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", { silent = true } },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", { silent = true } },
      { "<leader>fs", "<cmd>Telescope session-lens<CR>", { silent = true } },
    },
    config = function()
      local trouble = require("trouble.sources.telescope")
      local troublemaker = trouble.open

      vim.cmd([[
        highlight TelescopeBorder guifg=#585858
      ]])

      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- even more opts
            }),
          },
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
          },
          frecency = {
            show_scores = true,
            show_unindexed = false,
            ignore_patterns = { "*.git/*", "*/tmp/*" },
          },
          undo = {
            use_delta = true,
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = { preview_height = 0.8 },
          },
        },
        defaults = {
          max_results = 400,
          mappings = {
            i = { ["<leader>t"] = troublemaker },
            n = { ["<leader>t"] = troublemaker },
          },
        },
        pickers = {
          live_grep = {
            -- additional_args = function()
            --   return { "--max-count=10" }
            -- end,
          },
          find_files = {
            hidden = true,
            -- theme = "dropdown",
            file_ignore_patterns = { ".git", "node_modules" },
          },
        },
      })

      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("frecency")
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("undo")
      vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  },
}
