local M = {}

function M.setup()
  -- Hard-disable LSP dynamic file watching.
  --
  -- When a server registers workspace/didChangeWatchedFiles, Neovim walks the
  -- watch tree synchronously to install watchers. tailwindcss registers patterns
  -- rooted at the repo, and this repo holds 18 git worktrees under .worktrees/
  -- (each with its own node_modules), so that walk blocks the UI thread for
  -- several seconds on every file open.
  --
  -- Advertising didChangeWatchedFiles.dynamicRegistration = false in capabilities
  -- is the protocol-correct fix, but vim.lsp.config("*") does not reliably
  -- propagate to every server here (see note below), so some servers still
  -- register watchers. Replacing the watch backend with a no-op is the
  -- guaranteed fix. Trade-off: servers no longer auto-detect external file
  -- changes (e.g. config edits made outside Neovim); use <leader>rr to restart.
  local ok, watchfiles = pcall(require, "vim.lsp._watchfiles")
  if ok and watchfiles then
    watchfiles._watchfunc = function()
      return function() end
    end
  end

  local capabilities = require("lsp.capabilities").capabilities
  local on_attach = require("lsp.on_attach").on_attach

  -- Configure default LSP settings for all servers
  vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- NOTE: vim.lsp.config("*") not propagating on_attach —
  -- This is a known rough edge with the Neovim 0.11 API + mason-lspconfig. The on_attach in vim.lsp.config("*") should merge correctly, but if there's a version mismatch between mason-org/mason-lspconfig.nvim and Neovim, it might silently drop it.
  -- The safest fix is to explicitly add on_attach in pyright.lua (lsp/servers/pyright.lua:3):
  -- function M.setup()
  --   vim.lsp.config("pyright", {
  --     on_attach = require("lsp.on_attach").on_attach,  -- explicit, don't rely on "*"
  --     settings = { ... },
  --   })
  -- end

  -- Setup individual server configurations
  require("lsp.servers").setup()
end

return M
