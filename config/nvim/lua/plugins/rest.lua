return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  events = false,
  init = function()
    vim.filetype.add({
      extension = {
        ["http"] = "http",
      },
    })
  end,
  opts = {
    default_env = "default",
    kulala_core = {
      timeout = 120000,
    },
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

    -- Set up keymaps with <leader>r prefix, only for .http/.rest buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "http", "rest" },
      callback = function(ev)
        local map_opts = { buffer = ev.buf, silent = true }
        vim.keymap.set("n", "<leader>rs", kulala.run, vim.tbl_extend("force", map_opts, { desc = "Send the request" }))
        vim.keymap.set(
          "n",
          "<leader>rt",
          kulala.toggle_view,
          vim.tbl_extend("force", map_opts, { desc = "Toggle headers/body" })
        )
        vim.keymap.set("n", "<leader>rc", kulala.copy, vim.tbl_extend("force", map_opts, { desc = "Copy as cURL" }))
        vim.keymap.set(
          "n",
          "<leader>ri",
          kulala.inspect,
          vim.tbl_extend("force", map_opts, { desc = "Inspect request" })
        )
        vim.keymap.set(
          "n",
          "<leader>rj",
          kulala.jump_next,
          vim.tbl_extend("force", map_opts, { desc = "Jump to next request" })
        )
        vim.keymap.set(
          "n",
          "<leader>rk",
          kulala.jump_prev,
          vim.tbl_extend("force", map_opts, { desc = "Jump to previous request" })
        )
        vim.keymap.set(
          "n",
          "<leader>ra",
          kulala.run_all,
          vim.tbl_extend("force", map_opts, { desc = "Send all requests" })
        )
        vim.keymap.set(
          "n",
          "<leader>rb",
          kulala.scratchpad,
          vim.tbl_extend("force", map_opts, { desc = "Open scratchpad" })
        )
        vim.keymap.set("n", "<leader>ru", function()
          require("kulala.ui.auth_manager").open_auth_config()
        end, vim.tbl_extend("force", map_opts, { desc = "Open scratchpad" }))
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "kulala_ui",
      callback = function()
        vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { buffer = true, silent = true })
        vim.opt_local.wrap = false
      end,
    })
  end,
}
