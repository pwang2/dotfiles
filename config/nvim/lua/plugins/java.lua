return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "folke/which-key.nvim",
  },
  config = function()
    require("jdtls.jdtls_setup").setup()
    vim.cmd([[
      augroup jdtls_lsp
          autocmd!
          autocmd FileType java lua require'jdtls.jdtls_setup'.setup()
      augroup end
     ]])
  end,
}
