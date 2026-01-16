local M = {}

function M.setup()
  vim.lsp.config("vtsls", {
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
              location = vim.fn.stdpath("data")
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
              languages = { "vue" },
              configNamespace = "typescript",
            },
          },
        },
      },
    },
    --if you .ts file containes import "*.vue", you still need to use vtsls here with @vue/typescript-plugin
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  })
end

return M
