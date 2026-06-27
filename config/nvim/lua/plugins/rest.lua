return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  init = function()
    vim.filetype.add({
      extension = {
        ["http"] = "http",
      },
    })
  end,
  opts = {
    default_env = "dev",
    ui = {
      max_response_size = 1000000,
    },

    lsp = {
      enable = true,
      filetypes = { "http", "rest", "json", "yaml", "bruno" },
      keymaps = false,
      formatter = {},
      on_attach = nil,
    },

    additional_curl_options = { "--ssl-no-revoke", "-k" },
    -- Disable global keymaps for manual control
    global_keymaps = false,
    enable_global_keymaps = false,

    -- Default view when opening response
    default_view = "body",

    -- Show icons for HTTP methods and status codes
    show_icons = "on_request",

    -- Icons configuration
    icons = {
      inlay = {
        loading = "⏳",
        done = "✅",
        error = "❌",
      },
    },

    -- Display request headers in body
    headers_in_body = true,
  },
  config = function(_, opts)
    local kulala = require("kulala")
    kulala.setup(opts)

    -- Set up keymaps with <leader>r prefix
    vim.keymap.set("n", "<leader>rs", kulala.run, { desc = "Send the request", silent = true })
    vim.keymap.set("n", "<leader>rt", kulala.toggle_view, { desc = "Toggle headers/body", silent = true })
    vim.keymap.set("n", "<leader>rc", kulala.copy, { desc = "Copy as cURL", silent = true })
    vim.keymap.set("n", "<leader>ri", kulala.inspect, { desc = "Inspect request", silent = true })
    vim.keymap.set("n", "<leader>rj", kulala.jump_next, { desc = "Jump to next request", silent = true })
    vim.keymap.set("n", "<leader>rk", kulala.jump_prev, { desc = "Jump to previous request", silent = true })
    vim.keymap.set("n", "<leader>ra", kulala.run_all, { desc = "Send all requests", silent = true })
    vim.keymap.set("n", "<leader>rb", kulala.scratchpad, { desc = "Open scratchpad", silent = true })
    vim.keymap.set("n", "<leader>ru", function()
      require("kulala.ui.auth_manager").open_auth_config()
    end, { desc = "Open scratchpad", silent = true })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "kulala_ui",
      callback = function()
        vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>",  { buffer = true, silent = true })
        vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>",  { buffer = true, silent = true })
        vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>",    { buffer = true, silent = true })
        vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { buffer = true, silent = true })
      end,
    })
  end,
}
