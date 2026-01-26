require("config.lazy")

require("config.highlights").setup()

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

  autocmd BufEnter,CursorHold,CursorHoldI,FocusGained *
  \ if mode() !=# 'c' |
  \   checktime |
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
