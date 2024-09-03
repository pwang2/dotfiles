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
]])

vim.cmd([[
  autocmd BufNewFile,BufRead Dockerfile.* setlocal filetype=dockerfile
  autocmd BufNewFile,BufRead nginx.*      setlocal filetype=nginx
  autocmd BufNewFile,BufRead *.json       setlocal filetype=jsonc
  autocmd FileType json,jsonc             setlocal conceallevel=1
  autocmd FileType markdown               setlocal wrap linebreak

  "FileType will not work here.
]])

vim.cmd([[
  nnoremap <expr> j     v:count ? 'j' : 'gj'
  nnoremap <expr> k     v:count ? 'k' : 'gk'

  nnoremap <cr><cr>     <cmd>nohl<CR>
  nnoremap <leader>q    <cmd>bd <bar> bn<CR>
]])
