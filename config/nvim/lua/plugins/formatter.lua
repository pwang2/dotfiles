return {
  "mhartington/formatter.nvim",
  lazy = false,
  config = function()
    local prettier = require("formatter.defaults.prettier")
    require("formatter").setup({
      filetype = {
        sh = { require("formatter.filetypes.sh").shfmt },
        rust = { require("formatter.filetypes.rust").rustfmt },
        python = { require("formatter.filetypes.python").ruff }, --black
        lua = { require("formatter.filetypes.lua").stylua },
        typescript = { prettier },
        javascript = { prettier },
        css = { prettier },
        json = { prettier },
        jsonc = { prettier },
        vue = { prettier },
        html = { prettier },
        -- yaml = { require("formatter.filetypes.yaml").yamlfmt },
      },
    })

    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd
    augroup("__formatter__", { clear = true })
    autocmd("BufWritePost", { group = "__formatter__", command = ":FormatWrite" })
  end,

  keys = {
    { "<leader>f", "<cmd>FormatWrite<CR>", { silent = true } },
    { "<localleader>f", "<cmd>FormatWrite<CR>", { silent = true } },
  },
}
