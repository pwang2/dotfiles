return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = { "Telescope" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
    },
    keys = {
      { "<F1>", "<cmd>Telescope<CR>", { silent = true } },
      { "<C-p>", "<cmd>Telescope find_files<CR>", { silent = true } },
      { "<leader>f", "<cmd>Telescope resume<CR>", { silent = true } },
      { "<leader>s", "<cmd>Telescope symbols<CR>", { silent = true } },
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

      vim.cmd([[cab t Telescope]])
    end,
  },
}
