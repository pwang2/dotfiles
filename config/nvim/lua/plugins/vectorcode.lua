return {
  "Davidyz/VectorCode",
  version = "*",
  lazy = true,
  cmd = { "VectorCode" },
  build = "uv tool upgrade vectorcode", -- This helps keeping the CLI up-to-date
  dependencies = { "nvim-lua/plenary.nvim" },
  init = function()
    vim.api.nvim_create_user_command("VectorCodeEnable", function()
      -- TODO
      -- require("codecompanion").setup({
      --   extensions = {
      --     vectorcode = {
      --       enabled = true,
      --       opts = {
      --         add_tool = true,
      --         add_slash_command = true,
      --         tool_opts = {},
      --       },
      --     },
      --   },
      -- })
      -- print("Vectorcode extension enabled for CodeCompanion.")
    end, {})
  end,
}
