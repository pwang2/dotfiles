return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = function()
      -- Load types for every installed plugin, not only those used in opened
      -- buffers. Otherwise lua_ls workspace diagnostics on unopened config files
      -- report false undefined-type/global warnings. Generated from lazy.nvim,
      -- so there is no list to maintain.
      local library = { "lazy.nvim" }
      for _, plugin in ipairs(require("lazy").plugins()) do
        table.insert(library, plugin.name)
      end
      return { library = library }
    end,
  },
}
