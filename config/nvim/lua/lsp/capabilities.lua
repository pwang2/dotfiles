local M = {}

-- https://github.com/hrsh7th/cmp-nvim-lsp/issues/38#issuecomment-1815265121
---@class lsp.ClientCapabilities
M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities() --,
  -- Some LSP servers also expect to be informed about the extended client capabilities.
  -- require("lsp-file-operations").default_capabilities()
)

-- Disable LSP dynamic file watching. When a server (e.g. tailwindcss) registers
-- workspace/didChangeWatchedFiles with broad patterns rooted at the repo, Neovim
-- walks the entire tree synchronously to install watchers. This repo contains 18
-- git worktrees under .worktrees/ (each with its own node_modules), so that walk
-- blocks the UI thread for several seconds on every file open. Turning off
-- dynamicRegistration stops servers from requesting these watchers.
M.capabilities.workspace = M.capabilities.workspace or {}
M.capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = false }

return M
