return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    require("jdtls.jdtls_setup").setup()

    vim.cmd([[
      command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
      command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
      command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
      command! -buffer JdtJol lua require('jdtls').jol()")
      command! -buffer JdtBytecode lua require('jdtls').javap()")
      command! -buffer JdtJshell lua require('jdtls').jshell()")
    ]])
  end,
}
