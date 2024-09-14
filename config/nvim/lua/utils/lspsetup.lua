local M = {}

M.setup = function(lspconfigutil)
  local borderStyle = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
  require("lspconfig.ui.windows").default_options.border = borderStyle

  -- https://neovim.io/doc/user/lsp.html#lsp-handlers
  local origin_ofp = vim.lsp.util.open_floating_preview
  local patch_float_window = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = borderStyle
    opts.max_width = opts.max_width or 80
    return origin_ofp(contents, syntax, opts, ...)
  end
  vim.lsp.util.open_floating_preview = patch_float_window

  local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    local mk = function(key, cmd)
      vim.keymap.set("n", key, cmd, opts)
    end

    mk("gd", vim.lsp.buf.definition)
    mk("gv", function()
      vim.cmd([[vsplit]])
      vim.lsp.buf.definition()
    end)
    mk("gD", vim.lsp.buf.declaration)
    mk("gi", vim.lsp.buf.implementation)
    mk("<leader>k", vim.lsp.buf.signature_help)
    mk("<leader>D", vim.lsp.buf.type_definition)
    mk("<leader>rn", vim.lsp.buf.rename)
    mk("K", vim.lsp.buf.hover)
    mk("<space>e", vim.diagnostic.open_float)
    -- mk("<leader>q", vim.diagnostic.setloclist) --use trouble <leader>xx
    mk("[d", vim.diagnostic.goto_prev)
    mk("]d", vim.diagnostic.goto_next)
    vim.keymap.set("n", "<leader>ca", require("fastaction").code_action, opts)
    vim.keymap.set("v", "<leader>ca", require("fastaction").range_code_action, opts)

    --mk("<leader>ca", vim.lsp.code_action) --use fastaction.code_action
    --mk("<leader>f", vim.lsp.format) --use formatter.nvim
    --mk("<leader>f", vim.lsp.format) --use formatter.nvim
    --mk('gr', vim.lsp.references)  --use trouble gr
  end

  -- https://github.com/hrsh7th/cmp-nvim-lsp/issues/38#issuecomment-1815265121
  lspconfigutil.default_config = vim.tbl_extend("force", lspconfigutil.default_config, {
    on_attach = on_attach,
    capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    ),
  })
end
return M