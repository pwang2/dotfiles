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

local function make_capabilities()
  -- https://github.com/hrsh7th/cmp-nvim-lsp/issues/38#issuecomment-1815265121
  ---@class lsp.ClientCapabilities
  local capabilities = vim.tbl_deep_extend(
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
  capabilities.workspace = capabilities.workspace or {}
  capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = false }

  return capabilities
end

local function create_user_commands()
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
      local header = string.rep("-", (120 - #client.name) / 2)
        .. client.name
        .. string.rep("-", (120 - #client.name) / 2)
      local cap_lines = vim.split(vim.inspect(client.server_capabilities), "\n")
      vim.api.nvim_buf_set_lines(newBuffer, current_line, current_line, false, { header })
      vim.api.nvim_buf_set_lines(newBuffer, current_line + 1, -1, false, cap_lines)
      current_line = current_line + 1 + #cap_lines
    end
    vim.api.nvim_set_current_buf(newBuffer)
  end, {})

  vim.api.nvim_create_user_command("LspStop", function(cmd_opts)
    local name = cmd_opts.args
    local clients = vim.lsp.get_clients({ name = name })
    if #clients == 0 then
      vim.api.nvim_echo({ { "No LSP client named '" .. name .. "'", "ErrorMsg" } }, true, {})
      return
    end
    for _, client in ipairs(clients) do
      client:stop(true)
    end
  end, {
    nargs = 1,
    complete = function()
      local names = {}
      for _, client in ipairs(vim.lsp.get_clients()) do
        table.insert(names, client.name)
      end
      return names
    end,
  })
end

local function on_attach(client, bufnr)
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

  keygen("K", function()
    vim.lsp.buf.hover()
  end, "Hover documentation")

  keygen("<space>e", vim.diagnostic.open_float, "Show diagnostic message")
  keygen("[d", bind(vim.diagnostic.jump, { count = -1, float = true }), "Go to previous diagnostic")
  keygen("]d", bind(vim.diagnostic.jump, { count = 1, float = true }), "Go to next diagnostic")

  -- mimic vscode code action keybinding
  local function code_action_without_disabled()
    require("fastaction").code_action({
      filter = function(action)
        return action.disabled == nil
      end,
    })
  end
  keygen("<C-.>", code_action_without_disabled, "Code action")
  keygen("<leader>ca", code_action_without_disabled, "Code action")
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

  -- Disable it to prevent the document_color.lua crash
  client.server_capabilities.colorProvider = false
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "b0o/schemastore.nvim",
    { "Hoffs/omnisharp-extended-lsp.nvim" }, --used to make lsp gd working
    {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "VeryLazy",
      priority = 1000,
      config = function()
        require("tiny-inline-diagnostic").setup()
        vim.diagnostic.config({ virtual_text = false })
      end,
    },

    {
      "kosayoda/nvim-lightbulb",
      event = "LspAttach",
      config = function()
        -- https://github.com/kosayoda/nvim-lightbulb?tab=readme-ov-file#configuration
        require("nvim-lightbulb").setup({
          code_lenses = true,
          autocmd = { enabled = true },
        })
      end,
    },
    {
      "Chaitanyabsprip/fastaction.nvim",
      event = "LspAttach",
      -- https://github.com/Chaitanyabsprip/fastaction.nvim?tab=readme-ov-file#configuration
      opts = {
        dismiss_keys = { "j", "k", "<c-c>", "q" },
        keys = "qwertyuiopasdfghlzxcvbnm",
        priority = {
          typescript = {
            { pattern = "Add import from", key = "a", order = 1 },
          },
        },
      },
    },
    {
      "antosha417/nvim-lsp-file-operations",
      enabled = false,
      event = "VeryLazy",
      dependencies = {
        "nvim-lua/plenary.nvim",
        -- must be loaded first
        "nvim-tree/nvim-tree.lua",
      },
      config = function()
        require("lsp-file-operations").setup()
      end,
    },
  },
  config = function()
    -- Defaults for all servers. Per-server configs live in config/nvim/lsp/<name>.lua
    -- and are enabled by mason-lspconfig automatic_enable (see plugins/mason.lua).
    vim.lsp.config("*", {
      capabilities = make_capabilities(),
    })

    create_user_commands()

    -- Keymaps etc. for every client, however it was started (mason, ...)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          on_attach(client, args.buf)
        end
      end,
    })
  end,
}
