return {
  "neovim/nvim-lspconfig",
  keys = {
    { "<leader>rr", "<cmd>LspRestart<cr>", { silent = true } },
  },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "b0o/schemastore.nvim",
    {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "VeryLazy", -- Or `LspAttach`
      priority = 1000, -- needs to be loaded in first
      config = function()
        require("tiny-inline-diagnostic").setup()
        vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
      end,
    },
  },
  config = function()
    require("utils.lspsetup").setup()

    vim.lsp.config("omnisharp", { cmd = { "OmniSharp" } })

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

    vim.lsp.config("yamlls", {
      settings = {
        yaml = {
          schemaStore = {
            -- You must disable built-in schemaStore support if you want to use
            -- this plugin and its advanced options like `ignore`.
            enable = false,
            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
            url = "",
          },
          validate = { enable = true },
          --https://github.com/b0o/SchemaStore.nvim?tab=readme-ov-file#usage
          schemas = require("schemastore").yaml.schemas({
            extra = {
              {
                description = "kubernetes config",
                fileMatch = {
                  "deployment/**/*.yaml",
                },
                name = "k8s",
                url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.28.0-standalone/all.json",
              },
              -- {
              --   description = "Azure Pipelines",
              --   fileMatch = {
              --     "**/*.azure-pipelines.yml",
              --     "**/azure-pipelines.*.yml",
              --     "**/azure-pipelines.yml",
              --     "**/azure-pipelines.*.yaml",
              --     "**/*.azure-pipelines.yaml",
              --     "**/azure-pipelines.yaml",
              --   },
              --   name = "azure-pipelines",
              --   -- url = "https://raw.githubusercontent.com/Microsoft/azure-pipelines-vscode/refs/heads/main/service-schema.json",
              --   url = "file://" .. os.getenv("HOME") .. "/wbim-azure-pipelines-schema.json",
              -- },
            },
          }),
        },
      },
    })
    vim.lsp.config("jsonls", {
      filetypes = { "json", "jsonc" },
      settings = {
        json = {
          validate = { enable = true },
          schemas = require("schemastore").json.schemas(),
        },
      },
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          workspace = {
            -- library = vim.api.nvim_get_runtime_file("", true),
            library = {
              [vim.fn.stdpath("data") .. "/lazy/lazy.nvim"] = true, -- add lazy.nvim types
              [vim.fn.stdpath("config")] = true, -- your nvim config
              ["$VIMRUNTIME"] = true,
            },
            checkThirdParty = false,
          },
          diagnostics = { globals = { "vim", "hs", "spoon" } },
        },
      },
      on_init = function(client)
        local path = client.workspace_folders[1].name
        local uv = require("luv")
        if uv.fs_stat(path .. "/.luarc.json") or uv.fs_stat(path .. "/.luarc.jsonc") then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            version = "LuaJIT",
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
            },
          },
        })
      end,
    })

    vim.lsp.config("vtsls", {
      settings = {
        vtsls = {
          tsserver = {
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
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    })
  end,
}
