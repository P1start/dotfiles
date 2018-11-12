execute pathogen#infect()

let mapleader = '\'
let g:mapleader = '\'

set relativenumber
"set nu

set showcmd

set ruler

set autoindent
set shiftwidth=4
set tabstop=4
set expandtab

set incsearch

filetype plugin indent on

set history=700

filetype plugin on
filetype indent on

set encoding=utf8

set ffs=unix,dos,mac

set nobackup
set noswapfile

set undofile

set magic

set showmatch
set mat=2

set lazyredraw

set ignorecase
set smartcase

set so=999

" Remember position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Key mappings

"map j gj
"map k gk

ino <F5> <C-o>^<C-o>"jyW\begin{<C-o>$}<cr>\end{<C-o>"jp}<C-o>O

map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

map <M-h> gT
map <M-l> gt

map <M-1> :tabn 1<cr>
map <M-2> :tabn 2<cr>
map <M-3> :tabn 3<cr>
map <M-4> :tabn 4<cr>
map <M-5> :tabn 5<cr>
map <M-6> :tabn 6<cr>
map <M-7> :tabn 7<cr>
map <M-8> :tabn 8<cr>
map <M-9> :tablast<cr>

set hlsearch
cnoremap <silent> <Return> <cr>:noh<cr>
nnoremap <silent> n n:noh<cr>
nnoremap <silent> N N:noh<cr>
nnoremap <silent> * *:noh<cr>
nnoremap <silent> # #:noh<cr>

map <M-t> :tabnew<cr>
map <M-w> :tabclose<cr>
map <M-tab> :tabnext<cr>

ino {<cr> {<cr>}<esc>O

nmap <Leader>h :on<CR>:vs<CR><C-W>l:find %:t:r.h<CR><C-W>h

ino <M-CR> <esc>O

" vim-plug
call plug#begin()
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
call plug#end()

" LanguageClient
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'beta', 'rls'],
    \ }

let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Disable arrow keys

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Convenient onos
onoremap " i"
onoremap p i(
onoremap P a(
onoremap n( :<C-u>normal! f(vi(<cr>
onoremap l( :<C-u>normal! F)vi(<cr>

" D := dd
nnoremap D dd

set foldlevel=9999

colorscheme zellner
highlight LineNr ctermfg=8
highlight CursorLineNr ctermfg=grey
highlight clear SpellBad
highlight clear SpellCap
highlight SpellBad cterm=inverse
highlight SpellCap cterm=inverse
highlight StatusLine ctermfg=grey ctermbg=none cterm=bold
highlight StatusLineNC ctermfg=darkgrey cterm=italic
highlight VertSplit cterm=none ctermfg=darkgrey
highlight clear SignColumn
highlight clear TabLine
highlight clear TabLineSel
highlight clear TabLineFill
highlight TabLine ctermfg=grey cterm=bold
highlight TabLineSel ctermfg=red cterm=bold
highlight ColorColumn none

highlight GitGutterAdd ctermfg=yellow
highlight GitGutterChange ctermfg=green
highlight GitGutterChangeDelete ctermfg=green

let g:vimtex_view_general_viewer="evince"

let g:vimtex_compiler_latexmk = {
        \ 'options' : [
    \   '-pdf',
    \   '-pdflatex="xelatex --shell-escape %O %S"',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ]
    \}

let g:LanguageClient_diagnosticsDisplay = {
   \    1: {
   \        "name": "Error",
   \        "texthl": "ALEError",
   \        "signText": "*",
   \        "signTexthl": "ALEErrorSign",
   \    },
   \    2: {
   \        "name": "Warning",
   \        "texthl": "ALEWarning",
   \        "signText": "!",
   \        "signTexthl": "ALEWarningSign",
   \    },
   \    3: {
   \        "name": "Information",
   \        "texthl": "ALEInfo",
   \        "signText": "?",
   \        "signTexthl": "ALEInfoSign",
   \    },
   \    4: {
   \        "name": "Hint",
   \        "texthl": "ALEInfo",
   \        "signText": "?",
   \        "signTexthl": "ALEInfoSign",
   \    },
   \}

highlight ALEErrorSign ctermfg=red cterm=bold,inverse
highlight ALEWarningSign ctermfg=green cterm=inverse
highlight ALEInfoSign ctermfg=yellow cterm=inverse

highlight ALEError ctermfg=red cterm=bold,inverse
highlight ALEWarning ctermfg=green cterm=inverse
highlight ALEInfo ctermfg=yellow cterm=inverse
