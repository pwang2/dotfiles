local M = {}

function M.setup()
  -- Defaults for all servers. Per-server configs live in config/nvim/lsp/<name>.lua
  -- and are enabled by mason-lspconfig automatic_enable (see plugins/mason.lua).
  vim.lsp.config("*", {
    capabilities = require("lsp.capabilities").capabilities,
  })

  -- Keymaps etc. for every client, however it was started (mason, ...)
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        require("lsp.on_attach").on_attach(client, args.buf)
      end
    end,
  })
end

return M
