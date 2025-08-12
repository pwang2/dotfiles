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
        -- can we avoid the error here if configuration for linter is missing?
        local ok, err = pcall(require("lint").try_lint)
        if not ok then
          vim.notify("Linting failed: " .. tostring(err), vim.log.levels.ERROR)
        end
      end,
    })
  end,
}
