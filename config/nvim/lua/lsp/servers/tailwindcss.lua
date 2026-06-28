local M = {}

function M.setup()
  vim.lsp.config("tailwindcss", {
    settings = {
      tailwindCSS = {
        files = {
          -- The language server discovers a Tailwind "project" for every
          -- src/index.css entry point it finds. Git worktrees under
          -- .worktrees/ each ship their own index.css, so without excluding
          -- them the server reports ~18 projects and sends a multi-MB payload
          -- that Neovim JSON-decodes synchronously on the main thread, freezing
          -- the UI for several seconds on every TS/TSX open. The server does
          -- NOT honor .gitignore for discovery, so it must be excluded here.
          exclude = {
            "**/.git/**",
            "**/node_modules/**",
            "**/.hg/**",
            "**/.svn/**",
            "**/.worktrees/**",
            "**/.worktree/**",
          },
        },
      },
    },
  })
end

return M
