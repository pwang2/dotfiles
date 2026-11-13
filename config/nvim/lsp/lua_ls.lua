-- Neovim runtime/plugin library is provided by lazydev.nvim (plugins/lazydev.lua).
return {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      diagnostics = { globals = { "vim", "hs", "spoon" } },
      hint = { arrayIndex = "Disable" },
    },
  },
  on_init = function(client)
    -- workspace_folders is nil in single-file mode
    local folder = client.workspace_folders and client.workspace_folders[1]
    if folder then
      local path = folder.name
      if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = { version = "LuaJIT" },
    })
  end,
}
