require("config.lazy")

require("config.highlights").setup()

-- Helm: nvim has no built-in detection, so templates stay ft=yaml and helm_ls never attaches.
local function helm_chart_root(path, bufnr)
  return vim.fs.root(bufnr, { "Chart.yaml" }) or vim.fs.root(path, { "Chart.yaml" })
end
vim.filetype.add({
  extension = {
    tpl = function(path, bufnr)
      return helm_chart_root(path, bufnr) and "helm" or "smarty"
    end,
  },
  pattern = {
    [".*/templates/.*%.ya?ml"] = function(path, bufnr)
      return helm_chart_root(path, bufnr) and "helm" or "yaml"
    end,
    [".*/values[^/]*%.ya?ml"] = function(path, bufnr)
      return helm_chart_root(path, bufnr) and "yaml.helm-values" or "yaml"
    end,
  },
})

vim.cmd([[
  autocmd BufNewFile,BufRead Dockerfile.* setlocal filetype=dockerfile
  autocmd BufNewFile,BufRead nginx.*      setlocal filetype=nginx
  autocmd BufNewFile,BufRead *.json       setlocal filetype=jsonc
  autocmd BufNewFile,BufRead .envrc       setlocal filetype=sh

  autocmd FileType json,jsonc,markdown    setlocal conceallevel=1
  autocmd FileType markdown               setlocal wrap linebreak
  autocmd FileType helm                   setlocal syntax=yaml

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
]])

-- Esc leaves terminal mode, except in TUI apps that need Esc themselves (claude, lazygit, sidekick CLIs).
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("UserTermEsc", { clear = true }),
  callback = function(args)
    local name = vim.api.nvim_buf_get_name(args.buf)
    if name:match("claude") or name:match("lazygit") or name:match("sidekick") then
      return
    end
    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = args.buf, silent = true })
  end,
})

-- `:t` -> `:Telescope` only when `t` is the whole command line (keeps `:t.` copy-line working)
vim.cmd([[
  cnoreabbrev <expr> t (getcmdtype() ==# ':' && getcmdline() ==# 't') ? 'Telescope' : 't'
]])
