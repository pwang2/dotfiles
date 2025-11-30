return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "ToggleTermSendCurrentLine", "ToggleTermSendVisualSelection" },
  config = true,
  init = function()
    -- for file type sh , use <CR> to run current line
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "sh",
      callback = function()
        vim.keymap.set(
          "n",
          "<leader><CR>",
          ":ToggleTermSendCurrentLine<CR><CR>",
          { buffer = true, desc = "Run current line in terminal" }
        )
        vim.keymap.set(
          "v",
          "<leader><CR>",
          ":ToggleTermSendVisualSelection<CR><CR>",
          { buffer = true, desc = "Run visual selection in terminal" }
        )
      end,
    })
  end,
}
