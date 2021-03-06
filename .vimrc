" vim: foldmethod=marker
" {{{ flags
set nocompatible
set hidden
set hlsearch
set nowrap
set autoread
set autowrite
set smarttab
set linebreak
set expandtab
set splitbelow
set splitright
set noshowmode
set noruler
set laststatus=0
set noshowcmd
set viminfo       ^=%
set complete      -=i
set background     =light
set timeoutlen     =1000
set ttimeoutlen    =10
set clipboard      =unnamed
set so             =7
set signcolumn     =no
set showtabline    =0
set laststatus     =2
set tabstop        =2
set textwidth      =100
set shiftwidth     =2
set mouse          =a
set backspace      =eol,start,indent
set dir            =/var/tmp
set rtp            ^=$HOME
set fillchars      =""
" }}}

" {{{ plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'w0rp/ale'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'ervandew/supertab'
Plugin 'haya14busa/incsearch.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-obsession'
Plugin 'metakirby5/codi.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Valloric/MatchTagAlways'
"Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-ctrlspace/vim-ctrlspace'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'junegunn/goyo.vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'godlygeek/tabular'
Plugin 'simeji/winresizer'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'mileszs/ack.vim'
Plugin 'sjl/vitality.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'fugitive.vim'
Plugin 'nginx.vim'
Plugin 'suan/vim-instant-markdown'
Plugin 'loremipsum'
Plugin 'tkhren/vim-fake'
Plugin 'ternjs/tern_for_vim'
Plugin 'sbdchd/neoformat'
Plugin 'pangloss/vim-javascript'
Plugin 'djoshea/vim-autoread'
Plugin 'posva/vim-vue'
Plugin 'mattn/emmet-vim'
Plugin 'martinda/Jenkinsfile-vim-syntax'
Plugin 'guns/xterm-color-table.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/tsuquyomi'

Plugin 'edkolev/tmuxline.vim'
"Plugin 'edkolev/promptline.vim'
"Plugin 'hex.vim'
"Plugin 'Shougo/vimproc.vim'
"Plugin 'wesQ3/vim-windowswap'
"Plugin 'mtscout6/syntastic-local-eslint.vim'
"Plugin 'vim-stylus'
"Plugin 'Chiel92/vim-autoformat'
"Plugin 'mhinz/vim-startify'
"Plugin 'digitaltoad/vim-pug'
"Plugin 'flazz/vim-colorschemes'
call vundle#end()
filetype plugin indent on
syntax on
"}}}

" {{{ variables
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:prettier#config#print_width                  = 80
let mapleader                                      = ";"
let g:mapleader                                    = ";"
let s:hidden_all                                   = 0
let g:airline_section_error                        = airline#section#create_right(['ALE'])
let g:NERDTreeIgnore                               = ['\.DS_Store', 'yarn-error.log', 'yarn.lock', 'node_modules$[[dir]]']
let g:NERDTreeMinimalUI                            = 1
let g:NERDTreeAutoDeleteBuffer                     = 1
let g:NERDTreeMapJumpNextSibling                   = ''  " yield ctrl-j to tmux navigation
let g:NERDTreeMapJumpPrevSibling                   = ''  " yield ctrl-k to tmux navigation
let g:NERDCustomDelimiters                         = {'javascript' : { 'left': '// ', 'leftAlt': '/* ', 'rightAlt': ' */' }}
let g:ackprg                                       = 'ag --vimgrep'
let g:ackhighlight                                 = 1
let g:airline_powerline_fonts                      = 0
let g:airline#extensions#ale#enabled               = 1
let g:airline#extensions#tabline#enabled           = 0
let g:airline#extensions#tmuxline#enabled          = 0
let g:airline_theme                                = 'luna'
let g:airline_right_sep                            = ''
let g:airline_left_sep                             = ''
let g:airline_left_alt_sep                         = ''
let g:CtrlSpaceLoadLastWorkspaceOnStart            = 1
let g:CtrlSpaceSaveWorkspaceOnExit                 = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch               = 1
let g:CtrlSpaceGlobCommand                         = 'ag -l --nocolor -g ""'
let g:WebDevIconsNerdTreeAfterGlyphPadding         = ' '
let g:ycm_key_list_select_completion               = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion             = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType                = '<C-n>'
let g:UltiSnipsSnippetsDir                         = '/Users/pwang/.extra/UltiSnips'
let g:UltiSnipsSnippetDirectories                  = ['/Users/pwang/.extra/UltiSnips']
let g:UltiSnipsExpandTrigger                       = "<tab>"
let g:UltiSnipsJumpForwardTrigger                  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger                 = "<s-tab>"
let g:UltiSnipsEditSplit                           = "vertical"
let g:ctrlp_working_path_mode                      = 'ra'
let g:ctrlp_custom_ignore                          = '\v[\/](node_modules|bower_components|target|dist|\.git)'
let g:ctrlp_mruf_save_on_update                    = 1
let g:goyo_width                                   = 150
let g:windowswap_map_keys                          = 0
let g:mta_filetypes                                = { 'vue' : 2, 'html' : 1, 'xhtml' : 1, 'xml' : 1 }
let g:mta_use_matchparen_group                     = 1
let g:ale_fix_on_save                              = 1
let g:vue_disable_pre_processors                   = 1

let g:neoformat_javascript_eslint_d = {
        \ 'exe': 'eslint_d',
        \ 'args': ['--stdin','--fix-to-stdout', '--stdin-filename', '%:p'],
        \ 'stdin': 1
\ }

let g:neoformat_vue_eslint_d = {
        \ 'exe': 'eslint_d',
        \ 'args': ['--stdin','--fix-to-stdout', '--stdin-filename', '%:p'],
        \ 'stdin': 1
\ }

let g:neoformat_enabled_vue = ['eslint_d']

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\e[4 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[1 q\<Esc>\\"
    "let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    "let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI.="\e[5 q"
    let &t_SR.="\e[4 q"
    let &t_EI.="\e[1 q"
    "let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    "let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

" {{{ keymap
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<cr>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<cr>
nnoremap <Leader><Space>     :Goyo<cr>
nnoremap <Leader>t           :NERDTreeToggle<cr>
nnoremap <Leader>g           :Ack |
nnoremap <Leader>ev          :e $MYVIMRC<cr>
nnoremap <Leader>sv          :so $MYVIMRC<cr>
nnoremap <Leader>x           :bclose<cr>
nnoremap <leader>%           :MtaJumpToOtherTag<cr>
nnoremap gvf                 :vertical wincmd f<CR>
nnoremap gf                  <C-W>f<CR>

"noremap q                    <NOP>
noremap <leader>[            zfi{
noremap <leader>w            :w<cr>
noremap <leader>wa           :wa<cr>
noremap <leader>q            :q<cr>
noremap <leader>x            :call <SID>BufcloseCloseIt()<cr>

map j                        gj
map k                        gk
map <silent> <leader><cr>    :noh<cr>
map <space>                  <Plug>(incsearch-forward)
map ?                        <Plug>(incsearch-backward)
nmap s                       <Plug>(easymotion-overwin-f2)
" }}}

" {{{  augroup
augroup vimrc
  au!
  au User     GoyoEnter nested call <SID>goyo_enter()
  au User     GoyoLeave nested call <SID>goyo_leave()

  "need to use with vim-tmux-focus-events
  au FocusGained,VimEnter          *              set noinsertmode
  au BufWritePost                  .vimrc         call DeleteTrailingWS() | so $MYVIMRC
  au BufWritePost                  *.js           match OverLength /\%81v.*/
  au BufWritePost                  *.html         match OverLength /\%81v.*/
  au BufWritePre                   *.json         silent! if(expand('%:t')!="package.json") | exec ":%!prettier --stdin --parser json --print-width 100" | endif
  au BufWritePre                   .babelrc       silent! %!prettier --stdin --parser json --print-width 100
  au BufNewFile,BufFilePre,BufRead *.md           setlocal wrap filetype=markdown columns=80 fo+=t
  au BufRead,BufNewFile            .babelrc       setlocal filetype=json
  au BufRead                       nginx.conf     setlocal syntax=nginx
  au BufRead                       Dockerfile.*   setlocal filetype=Dockerfile
  " Remember info about open buffers on close
  au BufReadPost                   *              if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au InsertLeave                   *              if pumvisible() == 0|pclose|endif

  au FileType vue         noremap  <buffer> <leader>f :Neoformat eslint_d <bar> silent! call DeleteTrailingWS() <bar> syntax sync fromstart      <cr>
  au FileType javascript  noremap  <buffer> <leader>f :Neoformat eslint_d       <cr>
  au FileType json        noremap  <buffer> <leader>f :Neoformat prettier       <cr>
  au FileType markdown    noremap  <buffer> <leader>f :Neoformat prettier       <cr>
  au FileType css         noremap  <buffer> <leader>f :Neoformat prettier       <cr>
  au FileType scss        noremap  <buffer> <leader>f :Neoformat prettier       <cr>
  au FileType html        noremap  <buffer> <leader>f :Neoformat                <cr>
  au FileType javascript  noremap  <buffer> <Leader>l :JsDoc                    <cr>
  au FileType nerdtree    setlocal signcolumn=no nocursorline
  au FileType qf          setlocal cursorline
  au FileType javascript  setlocal signcolumn=yes
  au FileType vue         setlocal signcolumn=yes
augroup END
" }}}

"{{{ functions
function! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunction

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  hi StatusLineNC ctermfg=235
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set background=light
  call s:patch_colors()
endfunction

function! s:patch_colors()
  hi Pmenu           cterm=none       ctermbg=4
  hi ExtraWhitespace cterm=none       ctermbg=darkgreen
  hi NonText         cterm=none       ctermbg=none       ctermfg=0    guifg=bg
  hi VertSplit       cterm=none       ctermbg=none       ctermfg=8    guifg=white
  hi CursorLine      cterm=underline  ctermbg=none       ctermfg=none
  hi CursorColumn    cterm=none       ctermbg=yellow     ctermfg=none
  hi SignColumn      cterm=none       ctermbg=none       ctermfg=none
  hi Visual          cterm=reverse    ctermbg=none       ctermfg=none
  hi Search          cterm=none       ctermbg=red        ctermfg=235
  hi QuickFixLine    cterm=underline  ctermbg=none       ctermfg=blue
  hi MatchParen      cterm=bold       ctermbg=none       ctermfg=magenta
  hi OverLength      cterm=none       ctermbg=magenta    ctermfg=white
  hi Folded          cterm=bold       ctermbg=none       ctermfg=6
  hi Error           cterm=none       ctermbg=219        ctermfg=160
  hi link CtrlSpaceNormal Normal
  hi link CtrlSpaceSelected Visual
endfunction

function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")
    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif
    if bufnr("%") == l:currentBufNum
        new
    endif
    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! NERDTreeHighlightFile(extension, fg, bg)
    exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg
    exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

function! s:HideAll()
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
endfunction

function! s:ShowAll()
    set showmode
    set ruler
    set laststatus=2
    set showcmd
endfunction

function! s:RevealInFinder()
  if filereadable(expand("%"))
    let l:command = "open -R " . shellescape("%")
  elseif getftype(expand("%:p:h")) == "dir"
    let l:command = "open " . shellescape("%") . ":p:h"
  else
    let l:command = "open ."
  endif

  execute ":silent! !" . l:command

  " For terminal Vim not to look messed up.
  redraw!
endfunction
" }}}

" {{{ bootstrap init
call s:HideAll()
call s:patch_colors()

call NERDTreeHighlightFile('yml', '100', 'none')
call NERDTreeHighlightFile('json', '5', 'none')
call NERDTreeHighlightFile('md', '100', 'none')
call NERDTreeHighlightFile('sh', '1', 'none')

call fake#define('sex', 'fake#choice(["male", "female"])')
call fake#define('name', 'fake#int(1) ? fake#gen("male_name")' . ' : fake#gen("female_name")')
call fake#define('fullname', 'fake#gen("name") . " " . fake#gen("surname")')
call fake#define('sentense', 'fake#capitalize(' . 'join(map(range(fake#int(3,15)),"fake#gen(\"nonsense\")"))' . ' . fake#chars(1,"..............!?"))')
call fake#define('paragraph', 'join(map(range(fake#int(3,10)),"fake#gen(\"sentense\")"))')
call fake#define('ipsum', 'fake#gen("paragraph")')

"if exists('g:loaded_webdevicons')
  "call webdevicons#refresh()
"endif
" }}}

" {{{ command
command! Reveal  call <SID>RevealInFinder()
command! HideAll call <SID>HideAll()
command! ShowAll call <SID>ShowAll()
" }}}


