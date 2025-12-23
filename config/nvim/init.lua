require("config.lazy")

vim.g.loaded_node_provider = 0

vim.cmd([[
  hi link FoldColumn Comment
  hi link LspInlayHint Comment

  hi FloatBorder            guibg=NONE     guifg=#5b5b5b
  hi WinBorder              guibg=NONE     guifg=#5b5b5b
  hi WinSeparator                          guifg=#585858
  hi Visual                                guibg=#474e5d
  hi Folded                 guibg=NONE     guifg=#569cd6

  hi Pmenu                  guibg=NONE     guifg=#98a3ad
  hi PmenuSel               guibg=#6ac0ff  guifg=#f1f1f1
  hi Normal                 guibg=NONE
  hi NormalFloat            guibg=NONE     guifg=#b7cad4
  hi NonText                guibg=NONE     guifg=#81a46b

  hi LspCodeLens            guibg=NONE     guifg=#888888  gui=italic,underline

  hi DiffAdd                guibg=#223322  guifg=#a6e22e gui=bold
  hi DiffChange             guibg=#222233  guifg=#66d9ef
  " disabled as it mess up some markdown headings
  " hi DiffDelete             guibg=#332222  guifg=#f92672 gui=italic,bold
]])

vim.cmd([[
  autocmd BufNewFile,BufRead Dockerfile.* setlocal filetype=dockerfile
  autocmd BufNewFile,BufRead nginx.*      setlocal filetype=nginx
  autocmd BufNewFile,BufRead *.json       setlocal filetype=jsonc
  autocmd BufNewFile,BufRead .envrc       setlocal filetype=sh
  autocmd BufWritePost       *.toml       silent execute("!taplo format % >/dev/null 2>&1")

  autocmd FileType json,jsonc,markdown    setlocal conceallevel=1
  autocmd FileType markdown               setlocal wrap linebreak

 autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
]])

vim.cmd([[
  nnoremap <expr> j     v:count ? 'j' : 'gj'
  nnoremap <expr> k     v:count ? 'k' : 'gk'

  nnoremap <silent> <leader>w    <cmd>execute('write')<CR>
  nnoremap <silent> <cr><cr>     <cmd>nohl<CR>
]])

vim.cmd([[
  cab cc CodeCompanion
  cab ccc CodeCompanionChat
  cab t Telescope
]])
