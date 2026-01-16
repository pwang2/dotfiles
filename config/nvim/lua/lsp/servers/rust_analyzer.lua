local M = {}

function M.setup()
  vim.lsp.config("rust_analyzer", {
    settings = {
      ["rust-analyzer"] = {
        inlayHints = {
          enable = true,
          typeHints = { enable = true },
          parameterHints = { enable = true },
          chainingHints = { enable = true },
        },
        diagnostics = {
          enable = false,
        },
      },
    },
  })
end

return M
