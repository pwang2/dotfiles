require("config.lazy")

require("config.highlights").setup()

vim.cmd([[
  autocmd BufNewFile,BufRead Dockerfile.* setlocal filetype=dockerfile
  autocmd BufNewFile,BufRead nginx.*      setlocal filetype=nginx
  autocmd BufNewFile,BufRead *.json       setlocal filetype=jsonc
  autocmd BufNewFile,BufRead .envrc       setlocal filetype=sh

  autocmd FileType helm                   setlocal syntax=yaml
  autocmd FileType json,jsonc,markdown    setlocal conceallevel=1
  autocmd FileType markdown               setlocal wrap linebreak

  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  autocmd BufEnter,CursorHold,CursorHoldI,FocusGained *
  \ if mode() !=# 'c' && getcmdwintype() == '' |
  \   checktime |
  \ endif
]])

vim.cmd([[
  nnoremap <expr> j  v:count ? 'j' : 'gj'
  nnoremap <expr> k  v:count ? 'k' : 'gk'

  nnoremap <silent> <leader>p    <cmd>bp<CR>
  nnoremap <silent> <leader>n    <cmd>bn<CR>

  nnoremap <silent> <leader>cp   <cmd>let @+ = expand('%:p')<CR>
  nnoremap <silent> <leader>rr   <cmd>execute('lsp restart')<CR>
  nnoremap <silent> <leader>w    <cmd>execute('write')<CR>
  nnoremap <silent> <cr><cr>     <cmd>nohl<CR>

  tnoremap <silent> <Esc>        <C-\><C-n>
]])

vim.cmd([[
  cab t   Telescope
]])
