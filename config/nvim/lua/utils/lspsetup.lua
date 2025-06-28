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

  local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    local keygen = function(key, cmd, desc, mode)
      if desc then
        opts.desc = desc
      end
      if mode == nil then
        mode = "n"
      end
      vim.keymap.set(mode, key, cmd, opts)
    end

    -- keygen("gd", vim.lsp.buf.definition)  --use trouble
    keygen("gv", function()
      vim.cmd([[vsplit]])
      vim.lsp.buf.definition()
    end, "Go to definition in vertical split")
    -- keygen("gD", vim.lsp.buf.declaration)
    -- keygen("gi", vim.lsp.buf.implementation)
    keygen("<leader>k", vim.lsp.buf.signature_help, "Signature help")
    keygen("<leader>D", vim.lsp.buf.type_definition, "Type definition")
    keygen("rn", vim.lsp.buf.rename, "Rename")

    keygen("K", vim.lsp.buf.hover, "Hover documentation")
    keygen("<space>e", vim.diagnostic.open_float, "Show diagnostic message")
    -- keygen("<leader>q", vim.diagnostic.setloclist) --use trouble <leader>xx
    keygen("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
    keygen("]d", vim.diagnostic.goto_next, "Go to next diagnostic")

    keygen("<leader>ca", '<cmd>lua require("fastaction").code_action()<cr>', "Code action")
    keygen("<leader>ca", '<cmd>lua require("fastaction").range_code_action()<cr>', "Range code action", "v")
    keygen("<leader>cl", vim.lsp.codelens.run, "Run code lens action")

    --keygen("<leader>ca", vim.lsp.code_action) --use fastaction.code_action
    --keygen("<leader>f", vim.lsp.format) --use formatter.nvim
    --keygen("<leader>f", vim.lsp.format) --use formatter.nvim
    --keygen('gr', vim.lsp.references)  --use trouble gr
    if client.server_capabilities.codeLensProvider then
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })
    end

    --if current buffer filetype is C# and OmniSharp is attached, set omnisharp keymaps
    if client.name == "omnisharp" and vim.bo[bufnr].filetype == "cs" then
      vim.cmd([[
          nnoremap gd <cmd>lua require('omnisharp_extended').lsp_definition()<cr>
          nnoremap <leader>D <cmd>lua require('omnisharp_extended').lsp_type_definition()<cr>
          nnoremap gr <cmd>lua require('omnisharp_extended').lsp_references()<cr>
          nnoremap gi <cmd>lua require('omnisharp_extended').lsp_implementation()<cr>
        ]])
    end
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
