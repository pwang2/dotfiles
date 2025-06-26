local M = {}

vim.api.nvim_create_user_command("LspCap", function()
  local bufnr = vim.api.nvim_get_current_buf()
  ---@type vim.lsp.Client[]
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if #clients == 0 then
    vim.api.nvim_echo({ { "No LSP client attached", "ErrorMsg" } }, true, {})
    return
  end
  local newBuffer = vim.api.nvim_create_buf(false, true)
  local current_line = 0
  for _, client in pairs(clients) do
    local header = string.rep("-", (120 - #client.name) / 2) .. client.name .. string.rep("-", (120 - #client.name) / 2)
    local cap_lines = vim.split(vim.inspect(client.server_capabilities), "\n")
    vim.api.nvim_buf_set_lines(newBuffer, current_line, current_line, false, { header })
    vim.api.nvim_buf_set_lines(newBuffer, current_line + 1, -1, false, cap_lines)
    current_line = current_line + 1 + #cap_lines
  end
  vim.api.nvim_set_current_buf(newBuffer)
end, {})

M.setup = function(lspconfigutil)
  local borderStyle = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
  require("lspconfig.ui.windows").default_options.border = borderStyle

  local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    local mk = function(key, cmd, desc, mode)
      if desc then
        opts.desc = desc
      end
      if mode == nil then
        mode = "n"
      end
      vim.keymap.set(mode, key, cmd, opts)
    end

    -- mk("gd", vim.lsp.buf.definition)  --use trouble
    mk("gv", function()
      vim.cmd([[vsplit]])
      vim.lsp.buf.definition()
    end, "Go to definition in vertical split")
    -- mk("gD", vim.lsp.buf.declaration)
    -- mk("gi", vim.lsp.buf.implementation)
    mk("<leader>k", vim.lsp.buf.signature_help, "Signature help")
    mk("<leader>D", vim.lsp.buf.type_definition, "Type definition")
    mk("<leader>rn", vim.lsp.buf.rename, "Rename")

    mk("K", vim.lsp.buf.hover, "Hover documentation")
    mk("<space>e", vim.diagnostic.open_float, "Show diagnostic message")
    -- mk("<leader>q", vim.diagnostic.setloclist) --use trouble <leader>xx
    mk("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
    mk("]d", vim.diagnostic.goto_next, "Go to next diagnostic")

    mk("<leader>ca", '<cmd>lua require("fastaction").code_action()<cr>', "Code action")
    mk("<leader>ca", '<cmd>lua require("fastaction").range_code_action()<cr>', "Range code action", "v")

    --mk("<leader>ca", vim.lsp.code_action) --use fastaction.code_action
    --mk("<leader>f", vim.lsp.format) --use formatter.nvim
    --mk("<leader>f", vim.lsp.format) --use formatter.nvim
    --mk('gr', vim.lsp.references)  --use trouble gr
  end

  -- https://github.com/hrsh7th/cmp-nvim-lsp/issues/38#issuecomment-1815265121
  ---@class lsp.ClientCapabilities
  local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities()
  )

  lspconfigutil.default_config = vim.tbl_extend("force", lspconfigutil.default_config, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return M
