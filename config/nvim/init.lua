require("config.lazy")

vim.cmd([[
  hi link FoldColumn Comment

  hi WinSeparator                          guifg=#585858
  hi Visual                                guibg=#0087af
  hi Folded                 guibg=NONE     guifg=#569cd6

  hi FloatBorder            guibg=NONE     guifg=#569cd6
  hi Pmenu                  guibg=NONE     guifg=#898989
  hi PmenuSel               guibg=NONE     guifg=#6ac0ff gui=reverse
  hi Normal                 guibg=NONE
  hi NormalFloat            guibg=NONE     guifg=#b7cad4
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
  autocmd BufNewFile,BufRead Dockerfile.* setlocal filetype=dockerfile
  autocmd BufNewFile,BufRead nginx.*      setlocal filetype=nginx
  autocmd BufNewFile,BufRead *.json       setlocal filetype=jsonc
  autocmd FileType json,jsonc             setlocal conceallevel=1
]])

vim.cmd([[
  nnoremap <cr><cr>     <cmd>nohl<CR>
  nnoremap <leader>q    <cmd>bd<CR>
  nnoremap <leader>rr   <cmd>LspRestart<CR>
  nnoremap <leader>aa   <cmd>tabnew<bar>Alpha<CR>
]])
