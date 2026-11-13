return {
  "voldikss/vim-floaterm",
  cmd = { "FloatermToggle", "FloatermNew", "FloatermKill", "FloatermPrev", "FloatermNext" },
  keys = {
    { "<C-t>", ":FloatermToggle<CR>", noremap = true, silent = true },
  },
  init = function()
    vim.g.floaterm_height = 0.8
  end,
  config = function()
    vim.api.nvim_set_keymap(
      "t",
      "<C-t>",
      "<C-\\><C-n>:FloatermToggle<CR>",
      { noremap = true, silent = true }
    )
  end,
}

--Bizzare, have to use this way to make the open and close both working
