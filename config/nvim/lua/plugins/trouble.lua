return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {
    use_diagnostic_signs = true,
    -- 1. 禁用自动预览（最关键：禁止在光标/鼠标移动到某项时自动在主窗口打开/更新预览）
    auto_preview = false,

    -- 2. 如果开启了 hover 自动显示详情，取消其响应
    -- 确保键盘/鼠标移动不会自动预览文档或代码
    opts = {
      -- 确认 follow 设置为 false（避免根据主编辑器的光标位置自动追踪跳转 Trouble）
      follow = false,
    },
    diagnostics = {
      auto_preview = false, -- 单独确保诊断模式下禁用自动预览
      follow = false, -- 关闭跟随光标
    },
  },
  keys = {
    {
      "gi",
      "<cmd>Trouble lsp_implementations<cr>",
      desc = "Go to implementation(Trouble)",
    },
    {
      "gd",
      "<cmd>Trouble lsp_definitions<cr>",
      desc = "Go to definitions(Trouble)",
    },
    -- disabled as gt is taken by go to next tab
    -- {
    --   "gt",
    --   "<cmd>Trouble lsp_type_definitions<cr>",
    --   desc = "Go to type definitions(Trouble)",
    -- },
    {
      "gD",
      "<cmd>Trouble lsp_declarations<cr>",
      desc = "Go to declaration(Trouble)",
    },
    {
      "gO",
      "<cmd>Trouble lsp_document_symbols<cr>",
      desc = "Document symbols(Trouble)",
    },
    {
      "gr",
      "<cmd>Trouble lsp_references<cr>",
      desc = "Go to references (Trouble)",
    },
    {
      "<leader>x",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("QuickFixCmdPost", {
      callback = function()
        vim.cmd([[Trouble qflist open]])
      end,
    })
  end,
}
