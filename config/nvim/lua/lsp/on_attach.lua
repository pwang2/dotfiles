local M = {}

local function bind(func, ...)
  local bound_args = { ... }
  return function(...)
    local args = {}
    for _, v in ipairs(bound_args) do
      table.insert(args, v)
    end
    for _, v in ipairs({ ... }) do
      table.insert(args, v)
    end
    return func(table.unpack(args))
  end
end

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

M.on_attach = function(client, bufnr)
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

  keygen("gD", vim.lsp.buf.declaration)
  keygen("gi", vim.lsp.buf.implementation)
  keygen("<leader>k", vim.lsp.buf.signature_help, "Signature help")
  keygen("<leader>D", vim.lsp.buf.type_definition, "Type definition")
  keygen("<leader>rn", vim.lsp.buf.rename, "Rename")

  keygen("K", vim.lsp.buf.hover, "Hover documentation")

  keygen("<space>e", vim.diagnostic.open_float, "Show diagnostic message")
  keygen("[d", bind(vim.diagnostic.jump, { count = -1, float = true }), "Go to previous diagnostic")
  keygen("]d", bind(vim.diagnostic.jump, { count = 1, float = true }), "Go to next diagnostic")

  -- mimic vscode code action keybinding
  keygen("<C-.>", require("fastaction").code_action, "Code action")
  keygen("<leader>ca", require("fastaction").code_action, "Code action")
  keygen("<leader>cl", vim.lsp.codelens.run, "Run code lens action")
  keygen("<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, "Toggle Inlay Hints")

  keygen("<leader>wa", vim.lsp.buf.add_workspace_folder, "add workspace folder")
  keygen("<leader>wr", vim.lsp.buf.remove_workspace_folder, "remove workspace folder")
  keygen("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  local filetype = vim.bo[bufnr].filetype
  if client.name == "omnisharp" and filetype == "cs" then
    keygen("gd", require("omnisharp_extended").lsp_definition, "[cs]Go to definition")
    keygen("<leader>D", require("omnisharp_extended").lsp_type_definition, "[cs]Type definition")
    keygen("gi", require("omnisharp_extended").lsp_implementation, "[cs]Go to implementation")
  end

  if client.name == "jdtls" and filetype == "java" then
    keygen("<leader>di", function()
      require("jdtls").organize_imports()
    end, "[java]Organize imports")
    keygen("<leader>de", function()
      require("jdtls").extract_variable(true)
    end, "[java]Extract variable")
    keygen("<leader>dm", function()
      require("jdtls").extract_method(true)
    end, "[java]Extract method")
    keygen("<leader>dt", function()
      require("jdtls").test_class()
    end, "[java]Test class")
    keygen("<leader>dn", function()
      require("jdtls").test_nearest_method()
    end, "[java]Test nearest method")
  end

  -- Inlay hints disabled by default, use <leader>ih to toggle
end

return M
