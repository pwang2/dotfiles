return {
  "mfussenegger/nvim-lint",
  init = function()
    require("lint").linters_by_ft = {
      typescript = { "eslint_d" },
      javascript = { "eslint_d" },
      vue = { "eslint_d" },
      lua = { "luacheck" },
      -- sh = { "shellcheck" }, --bashls already have this as diagnose
      python = { "ruff" }, --pylint
      yaml = { "yamllint" },
    }

    vim.api.nvim_create_augroup("__lint__", { clear = true })
    vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "BufEnter", "BufWritePost" }, {
      group = "__lint__",
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
