-- Only attaches to vue files (tsc owns js/ts) to avoid conflict.
return {
  settings = {
    typescript = {
      inlayHints = {
        -- TODO: temp disable
        enabled = false,
        parameterNames = {
          enabled = "literals", -- 'literals' | 'all' | 'none'
        },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    vtsls = {
      tsserver = {
        useSyntaxServer = false,
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
    },
  },
  -- if a .ts file imports "*.vue", vtsls with @vue/typescript-plugin is still needed
  -- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  filetypes = { "vue" },
}
