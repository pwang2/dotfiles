return {
  "ravitemer/mcphub.nvim",
  -- enabled = false,
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "MCPHub", -- lazy load by default
  build = "bundled_build.lua",
  -- build = "npm install -g mcp-hub@latest", -- Installs globally
  opts = {
    use_bundled_binary = true,
  },
}
