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
    local lspconfig = require("lspconfig")
    local lspsetup = require("utils.lspsetup")

    -- setup default on_attach and capabilities
    lspsetup.setup(lspconfig.util)

    lspconfig.omnisharp.setup({ cmd = { "OmniSharp" } })
    lspconfig.rust_analyzer.setup({
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = true,
          },
        },
      },
    })

    lspconfig.gopls.setup({})
    lspconfig.pyright.setup({})
    lspconfig.tailwindcss.setup({ filetypes = { "vue", "html", "css", "javascript", "typescript" } })
    lspconfig.nginx_language_server.setup({})
    lspconfig.bashls.setup({})
    lspconfig.cssls.setup({
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

    -- lspconfig.azure_pipelines_ls.setup({
    --   root_dir = lspconfig.util.root_pattern("azure-pipelines.y*l"),
    -- })
    lspconfig.yamlls.setup({
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

    lspconfig.jsonls.setup({
      filetypes = { "json", "jsonc" },
      settings = {
        json = {
          validate = { enable = true },
          schemas = require("schemastore").json.schemas(),
        },
      },
    })

    lspconfig.lua_ls.setup({
      settings = { Lua = { diagnostics = { globals = { "vim", "hs", "spoon" } } } },
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

    -- https://github.com/vuejs/language-tools?tab=readme-ov-file#community-integration
    -- lspconfig.ts_ls.setup({
    --   init_options = {
    --     plugins = {
    --       {
    --         name = "@vue/typescript-plugin",
    --         location = vim.fn.stdpath("data")
    --           .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
    --         languages = { "vue" },
    --       },
    --     },
    --   },
    --   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    --   root_dir = function(fname)
    --     -- this is workaround for monorepo where the typescript is installed to the root node_modules
    --     local gitRoot = vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
    --
    --     if gitRoot and vim.fn.filereadable(gitRoot .. "/package.json") == 1 then
    --       return gitRoot
    --     end
    --     return vim.fs.dirname(vim.fs.find("node_modules", { path = fname, upward = true })[1])
    --   end,
    -- })

    -- -- "Hybrid" mode, volar exclusively manages the CSS/HTML sections.
    -- lspconfig.volar.setup({
    --   init_options = {
    --     vue = {
    --       hybridMode = true,
    --     },
    --     typescript = {
    --       tsdk = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/typescript/lib",
    --     },
    --   },
    --   on_new_config = function(new_config, new_root_dir)
    --     local lib_path = new_root_dir .. "/node_modules/typescript/lib"
    --     if lib_path then
    --       new_config.init_options.typescript.tsdk = lib_path
    --     end
    --   end,
    --   root_dir = function(fname)
    --     -- this is workaround for monorepo where the typescript is installed to the root node_modules
    --     local gitRoot = vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
    --     if gitRoot and vim.fn.filereadable(gitRoot .. "/package.json") == 1 then
    --       return gitRoot
    --     end
    --     local node_modules_path = vim.fs.dirname(vim.fs.find("node_modules", { path = fname, upward = true })[1])
    --     return node_modules_path
    --   end,
    -- })
    --
    --
    local vue_language_server_path = vim.fn.stdpath("data")
      .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
    local vue_plugin = {
      name = "@vue/typescript-plugin",
      location = vue_language_server_path,
      languages = { "vue" },
      configNamespace = "typescript",
    }
    local vtsls_config = {
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = {
              vue_plugin,
            },
          },
        },
      },
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    }

    local vue_ls_config = {
      on_init = function(client)
        client.handlers["tsserver/request"] = function(_, result, context)
          local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
          if #clients == 0 then
            vim.notify("Could not find `vtsls` lsp client, `vue_ls` would not work without it.", vim.log.levels.ERROR)
            return
          end
          local ts_client = clients[1]

          local param = unpack(result)
          local id, command, payload = unpack(param)
          ts_client:exec_cmd({
            title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
            command = "typescript.tsserverRequest",
            arguments = {
              command,
              payload,
            },
          }, { bufnr = context.bufnr }, function(_, r)
            local response_data = { { id, r.body } }
            ---@diagnostic disable-next-line: param-type-mismatch
            client:notify("tsserver/response", response_data)
          end)
        end
      end,
    }

    lspconfig.vtsls.setup(vtsls_config)
    lspconfig.volar.setup(vue_ls_config)
  end,
}
