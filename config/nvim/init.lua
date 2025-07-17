require("config.lazy")

vim.o.guifont = "JetbrainsMono Nerd Font:h12" -- text below applies for VimScript
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

vim.g.loaded_node_provider = 0

vim.cmd([[
  hi link FoldColumn Comment

  hi FloatBorder            guibg=NONE     guifg=#585858
  hi WinBorder              guibg=NONE     guifg=#585858
  hi WinSeparator                          guifg=#585858
  hi Visual                                guibg=#474e5d
  hi Folded                 guibg=NONE     guifg=#569cd6

  hi Pmenu                  guibg=NONE     guifg=#98a3ad
  hi PmenuSel               guibg=#6ac0ff  guifg=#f1f1f1
  hi Normal                 guibg=NONE
  hi NormalFloat            guibg=NONE     guifg=#b7cad4
  hi NonText                guibg=NONE     guifg=#81a46b
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
  nnoremap <silent> cab  <cmd>execute('%bd<bar>e#<bar>bd#')<cr>

  nnoremap <silent> <leader>aa   <cmd>Alpha<CR>
  nnoremap <silent> <cr><cr>     <cmd>nohl<CR>
]])

vim.cmd([[
  cab cc CodeCompanion
  cab t Telescope
]])

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.jsonc", "tsconfig.json", "appsettings.*json" },
  callback = function()
    vim.bo.filetype = "jsonc"
  end,
})
