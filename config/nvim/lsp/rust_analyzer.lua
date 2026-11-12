return {
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
}
