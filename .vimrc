" vim: foldmethod=marker
" {{{ flags
set shell=/usr/local/bin/zsh\ -l
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
"set fillchars      =vert:\⎸
"set fillchars      =vert:\│
" Add home directory to runtimepath
" }}}

" {{{ plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'w0rp/ale'
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
Plugin 'metakirby5/codi.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Valloric/MatchTagAlways'
Plugin 'ryanoasis/vim-devicons'
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
Plugin 'heavenshell/vim-jsdoc'
Plugin 'mileszs/ack.vim'
Plugin 'sjl/vitality.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'fugitive.vim'
Plugin 'nginx.vim'
Plugin 'suan/vim-instant-markdown'
Plugin 'loremipsum'
Plugin 'ternjs/tern_for_vim'
Plugin 'sbdchd/neoformat'
Plugin 'pangloss/vim-javascript'
Plugin 'djoshea/vim-autoread'
Plugin 'posva/vim-vue'
Plugin 'mattn/emmet-vim'
Plugin 'martinda/Jenkinsfile-vim-syntax'

Plugin 'guns/xterm-color-table.vim'
"Plugin 'edkolev/tmuxline.vim'
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
"Plugin 'leafgarland/typescript-vim'
"Plugin 'Quramy/tsuquyomi'
call vundle#end()
filetype plugin indent on
syntax on
"}}}

" {{{ variables
let s:hidden_all                           = 0
let g:airline_section_error                = airline#section#create_right(['ALE'])
let mapleader                              = ";"
let g:mapleader                            = ";"
let g:NERDTreeIgnore                       = ['\.DS_Store']
let g:NERDTreeWinPos                       = "left"
let g:ackprg                               = 'ag --vimgrep'
let g:ackhighlight                         = 1
let g:airline_powerline_fonts              = 1
let g:airline#extensions#ale#enabled       = 1
let g:airline#extensions#tabline#enabled   = 0
let g:airline#extensions#tmuxline#enabled  = 0
let g:airline_theme                        = 'luna'
let g:airline_right_sep                    = ''
let g:airline_left_sep                     = ''
let g:airline_left_alt_sep                 = ''
let g:CtrlSpaceLoadLastWorkspaceOnStart    = 1
let g:CtrlSpaceSaveWorkspaceOnExit         = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch       = 1
let g:CtrlSpaceGlobCommand                 = 'ag -l --nocolor -g ""'
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
let g:ycm_key_list_select_completion       = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion     = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType        = '<C-n>'
let g:UltiSnipsSnippetsDir                 ='/Users/pwang/Documents/UltiSnips'
let g:UltiSnipsSnippetDirectories          = ['/Users/pwang/Documents/UltiSnips']
let g:UltiSnipsExpandTrigger               = "<tab>"
let g:UltiSnipsJumpForwardTrigger          = "<tab>"
let g:UltiSnipsJumpBackwardTrigger         = "<s-tab>"
let g:UltiSnipsEditSplit                   = "vertical"
let g:ctrlp_working_path_mode              = 'ra'
let g:ctrlp_custom_ignore                  = '\v[\/](node_modules|bower_components|target|dist|\.git)'
let g:ctrlp_mruf_save_on_update            = 1
let g:goyo_width                           = 150
let g:ale_linters                          = {'javascript': ['eslint'], 'vue':['tidy','eslint'], 'html':['tidy']}
let g:ale_html_tidy_executable             = "/usr/local/bin/tidy" " self build tidy
let g:ale_html_tidy_options                = "-config $HOME/.tidyrc"
let g:NERDCustomDelimiters                 = {'javascript' : { 'left': '// ', 'leftAlt': '/* ', 'rightAlt': ' */' }}
let g:windowswap_map_keys                  = 0 "prevent default bindings
let g:mta_use_matchparen_group             = 1
let g:airline_section_error                = airline#section#create_right(['ALE'])
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

" {{{ keymap
nnoremap <S-h> :call ToggleHiddenAll()<CR>
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<cr>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<cr>
nnoremap <Leader><Space>     :Goyo<cr>
nnoremap <Leader>t           :NERDTreeToggle<cr>
nnoremap <Leader>g           :Ack |
nnoremap <Leader>ev          :e $MYVIMRC<cr>
nnoremap <Leader>sv          :so $MYVIMRC<cr>
nnoremap <Leader>x           :bclose<cr>
nnoremap <leader>%           :MtaJumpToOtherTag<cr>

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
nmap <leader>"               ysiw"
nmap <leader>'               ysiw'
" }}}

" {{{  augroup
augroup vimrc
  au!
  au User     GoyoEnter nested call <SID>goyo_enter()
  au User     GoyoLeave nested call <SID>goyo_leave()

  "need to use with vim-tmux-focus-events
  au FocusGained,VimEnter          *         set noinsertmode

  au BufWritePost                  .vimrc    call DeleteTrailingWS() | so $MYVIMRC
  au BufWritePost                  *.js      match OverLength /\%81v.*/
  au BufWritePost                  *.html    match OverLength /\%81v.*/
  "au BufWritePre                   *.vue     execute ":normal zE" | call FormatVue()
  "au BufWritePre                   *.js      execute ":normal zE" | call FormatJs()
  au BufWritePre                   *.json    silent! if(expand('%:t')!="package.json") | exec ":%!prettier --stdin --parser json" | endif
  au BufWritePre                   .babelrc  silent! %!prettier --stdin --parser json
  au BufRead,BufNewFile            *.vue     setlocal filetype=js.html.vue
  au BufNewFile,BufFilePre,BufRead *.md      setlocal filetype=markdown tw=80 fo+=t
  au BufRead,BufNewFile            .babelrc  setlocal filetype=json
  " Remember info about open buffers on close
  au BufReadPost                   *         if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au VimEnter,BufRead              *         call ToggleHiddenAll()
  au ColorScheme                   default   call s:patch_colors()

  au FileType nerdtree    setlocal signcolumn=no nocursorline
  au FileType markdown    setlocal tw=10000
  au FileType qf          setlocal cursorline
  au FileType javascript  setlocal signcolumn=yes
  au FileType vue         setlocal signcolumn=yes
  au FileType vue         noremap  <buffer> <leader>f :call FormatVue()<cr>
  au FileType javascript  noremap  <buffer> <leader>f :call FormatJs()<cr>
  au FileType json        noremap  <buffer> <leader>f :Neoformat prettier  <cr>
  au FileType css         noremap  <buffer> <leader>f :Neoformat prettier  <cr>
  au FileType scss        noremap  <buffer> <leader>f :Neoformat prettier  <cr>
  au FileType html        noremap  <buffer> <leader>f :Neoformat tidy      <cr>
  au FileType javascript  noremap  <buffer> <Leader>l :JsDoc<cr>
augroup END
" }}}

" {{{ functions
function! FormatVue()
   let winview = winsaveview()

   silent! /<script>/+1,/<\/script>/-1 !
         \   cat |
         \   ( [[ -f "$(dirname $(npm -s root))/.eslintrc.js" ]] && eslint_d --stdin --fix --fix-to-stdout - || cat ) |
         \   prettier --stdin --single-quote --tab-width "${TAB_SIZE:-2}"

   silent! /<style/+1,/<\/style>/-1 !
         \    prettier --stdin --parser css

   silent! /<template>/,/<\/template>/ !
         \    perl -pe 's/ :(?=(?:[^"]*"[^"]*")*[^"]*$)/ v-bind:/g' - |
         \    perl -pe 's/ @(?=(?:[^"]*"[^"]*")*[^"]*$)/ v-on:/g' - |
         \    tidy -config "$HOME/.tidyrc" - |
         \    sed -e s/v-bind:/:/g - |
         \    sed -e s/v-on:/@/g -

   call winrestview(winview)
   syntax sync fromstart
endfunction

function! FormatJs()
   let winview = winsaveview()
   silent! % !
         \   cat |
         \   ( [[ -f "$(dirname $(npm -s root))/.eslintrc.js" ]] && eslint_d --stdin --fix --fix-to-stdout || cat ) |
         \   prettier --stdin --single-quote --tab-width ${TAB_SIZE:-2}
   call winrestview(winview)
endfunction

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
endfunction

function! s:patch_colors()
  hi ExtraWhitespace cterm=none       ctermbg=darkgreen
  hi NonText         cterm=none       ctermbg=none       ctermfg=15
  hi VertSplit       cterm=none       ctermbg=none       ctermfg=15
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

function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
" }}}

" {{{ bootstrap init
call NERDTreeHighlightFile('yml', '100', 'none')
call NERDTreeHighlightFile('json', '5', 'none')
call NERDTreeHighlightFile('md', '100', 'none')
call NERDTreeHighlightFile('sh', '1', 'none')
call s:patch_colors()
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif
call airline#parts#define_function('ALE', 'ALEGetStatusLine')
call airline#parts#define_condition('ALE', 'exists("*ALEGetStatusLine")')
" }}}
