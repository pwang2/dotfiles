return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/vaults/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/vaults/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "para",
        path = "~/vaults/PARA",
      },
    },
  },
}
