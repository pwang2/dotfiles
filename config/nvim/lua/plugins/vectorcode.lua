return {
  "Davidyz/VectorCode",
  version = "*",
  build = "uv tool upgrade vectorcode", -- This helps keeping the CLI up-to-date
  dependencies = { "nvim-lua/plenary.nvim" },
}
