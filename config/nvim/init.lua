require("config.lazy")

vim.o.guifont = "JetbrainsMono Nerd Font:h12" -- text below applies for VimScript
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

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
  autocmd BufWritePost       *.toml       silent execute("!taplo format % >/dev/null 2>&1")

  autocmd FileType json,jsonc             setlocal conceallevel=1
  autocmd FileType markdown               setlocal wrap linebreak
]])

vim.cmd([[
  nnoremap <expr> j     v:count ? 'j' : 'gj'
  nnoremap <expr> k     v:count ? 'k' : 'gk'

  nnoremap <cr><cr>     <cmd>nohl<CR>
  nnoremap <leader>q    <cmd>bd <bar> bn<CR>
]])
