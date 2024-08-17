require("config.lazy")

vim.cmd([[
  hi link FoldColumn Comment

  hi WinSeparator                          guifg=#585858
  hi Folded                 guibg=NONE     guifg=#569cd6

  hi FloatBorder            guibg=NONE     guifg=#569cd6
  hi Pmenu                  guibg=NONE     guifg=#898989
  hi PmenuSel               guibg=NONE     guifg=#6ac0ff gui=reverse
  hi Normal                 guibg=NONE
  hi NormalFloat            guibg=NONE
  hi CmpItemAbbrDeprecated  guibg=NONE     guifg=#808080 gui=strikethrough
  hi CmpItemAbbrMatch       guibg=NONE     guifg=#56d690
  hi CmpItemAbbrMatchFuzzy  guibg=NONE     guifg=#569CD6
  hi CmpItemKindVariable    guibg=NONE     guifg=#9CDCFE
  hi CmpItemKindInterface   guibg=NONE     guifg=#9CDCFE
  hi CmpItemKindText        guibg=NONE     guifg=#9CDCFE
  hi CmpItemKindFunction    guibg=NONE     guifg=#C586C0
  hi CmpItemKindMethod      guibg=NONE     guifg=#C586C0
  hi CmpItemKindKeyword     guibg=NONE     guifg=#D4D4D4
  hi CmpItemKindProperty    guibg=NONE     guifg=#D4D4D4
  hi CmpItemKindUnit        guibg=NONE     guifg=#D4D4D4
]])

vim.cmd([[
  autocmd BufNewFile,BufRead Dockerfile.* set filetype=dockerfile
  autocmd BufNewFile,BufRead nginx.*      set filetype=nginx
  autocmd FileType json,jsonc             set conceallevel=1
]])

-- put the key binding here to allow using :Command to load the plugin in a lazy way
vim.cmd([[
  nnoremap <C-p>      <cmd>Telescope find_files<CR>
  nnoremap <leader>ff <cmd>Telescope find_files<CR>
  nnoremap <leader>f  <cmd>Telescope resume<CR>
  nnoremap <leader>fg <cmd>Telescope live_grep<CR>
  nnoremap <leader>fb <cmd>Telescope buffers<CR>
  nnoremap <leader>fh <cmd>Telescope help_tags<CR>

  nnoremap <leader>rr <cmd>LspRestart<CR>
  nnoremap <cr><cr>   :nohlsearch<CR>
]])
