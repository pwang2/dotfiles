return {
  "Davidyz/VectorCode",
  version = "*",
  lazy = true,
  build = "uv tool upgrade vectorcode", -- This helps keeping the CLI up-to-date
  dependencies = { "nvim-lua/plenary.nvim" },
}
