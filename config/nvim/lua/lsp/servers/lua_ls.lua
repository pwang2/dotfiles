local M = {}

function M.setup()
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        workspace = {
          library = {
            [vim.fn.stdpath("data") .. "/lazy/lazy.nvim"] = true,
            [vim.fn.stdpath("config")] = true,
            ["$VIMRUNTIME"] = true,
          },
          checkThirdParty = false,
        },
        diagnostics = { globals = { "vim", "hs", "spoon" } },
        hint = { arrayIndex = "Disable" },
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
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
      })
    end,
  })
end

return M
