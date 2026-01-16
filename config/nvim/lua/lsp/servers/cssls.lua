local M = {}

function M.setup()
  vim.lsp.config("cssls", {
    settings = {
      css = {
        lint = {
          unknownAtRules = "ignore",
        },
        validate = true,
      },
      scss = {
        validate = true,
      },
      less = {
        validate = true,
      },
    },
  })
end

return M
