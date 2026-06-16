return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  -- keys = {
  --   { "<leader>Rs", "", desc = "Send the request" },
  --   { "<leader>Rt", "", desc = "Toggle headers/body" },
  --   { "<leader>Rc", "", desc = "Copy as cURL" },
  --   { "<leader>Ri", "", desc = "Inspect request" },
  --   { "<leader>Rj", "", desc = "Jump to next request" },
  --   { "<leader>Rk", "", desc = "Jump to previous request" },
  --   { "<leader>Ra", "", desc = "Send all requests" },
  --   { "<leader>Rb", "", desc = "Open scratchpad" },
  -- },
  opts = {
    response_size_limit = 1000000,

    additional_curl_options = { "--ssl-no-revoke", "-k" },
    -- Disable global keymaps for manual control
    global_keymaps = false,

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

    -- Content type highlighting
    contenttypes = {
      ["application/json"] = {
        ft = "json",
        formatter = { "oxfmt", "." },
      },
      ["application/xml"] = {
        ft = "xml",
        formatter = { "xmllint", "--format", "-" },
      },
      ["text/html"] = {
        ft = "html",
        formatter = { "xmllint", "--format", "--html", "-" },
      },
    },
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
  end,
}
