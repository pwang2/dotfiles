return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = { use_diagnostic_signs = true },
  keys = {
    {
      "gi",
      "<cmd>Trouble lsp_implementations<cr>",
      desc = "Go to implementation(Trouble)",
    },
    {
      "gd",
      "<cmd>Trouble lsp_definitions<cr>",
      desc = "Go to definitions(Trouble)",
    },
    {
      "gt",
      "<cmd>Trouble lsp_type_definitions<cr>",
      desc = "Go to type definitions(Trouble)",
    },
    {
      "gD",
      "<cmd>Trouble lsp_declarations<cr>",
      desc = "Go to declaration(Trouble)",
    },
    {
      "gr",
      "<cmd>Trouble lsp_references<cr>",
      desc = "Go to references (Trouble)",
    },
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("QuickFixCmdPost", {
      callback = function()
        vim.cmd([[Trouble qflist open]])
      end,
    })
  end,
}
