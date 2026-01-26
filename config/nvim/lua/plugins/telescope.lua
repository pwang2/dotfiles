return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "folke/trouble.nvim", lazy = true },
    { "nvim-telescope/telescope-fzf-native.nvim", lazy = true },
    { "nvim-telescope/telescope-ui-select.nvim", lazy = true },
    { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
    { "nvim-telescope/telescope-frecency.nvim", lazy = true },
    { "debugloop/telescope-undo.nvim", lazy = true },
    { "nvim-telescope/telescope-symbols.nvim", lazy = true },
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
    local telescope = require("telescope")
    local highlights = require("config.highlights")

    -- Defer non-critical setup
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = highlights.colors.separator })

      -- Autocmd for window border
      vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopeFindPre",
        callback = function()
          vim.opt_local.winborder = "none"
          vim.api.nvim_create_autocmd("WinLeave", {
            once = true,
            callback = function()
              vim.opt_local.winborder = "rounded"
            end,
          })
        end,
      })
    end)

    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
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
          i = {
            ["<leader>t"] = function(...)
              require("trouble.sources.telescope").open(...)
            end,
          },
          n = {
            ["<leader>t"] = function(...)
              require("trouble.sources.telescope").open(...)
            end,
          },
        },
      },
      pickers = {
        live_grep = {},
        find_files = {
          hidden = true,
          file_ignore_patterns = { ".git", "node_modules" },
        },
      },
    })

    -- Lazy load extensions on demand
    vim.schedule(function()
      telescope.load_extension("ui-select")
      telescope.load_extension("frecency")
      telescope.load_extension("file_browser")
      telescope.load_extension("undo")
    end)

    vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
  end,
}
