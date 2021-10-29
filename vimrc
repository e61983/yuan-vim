set nocompatible              " be iMproved, required

let iCanHazVimPlug=1
let plug_vim=expand('~/.vim/autoload/plug.vim')
if !filereadable(plug_vim)
    echo "Installing vim-plug.."
    echo ""
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let iCanHazVimPlug=0
endif

call plug#begin('~/.vim/plugged')

" common
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"for web development
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'

"for go development
Plug 'fatih/vim-go'
Plug 'nsf/gocode'

" All of your Plugs must be added before the following line
call plug#end()            " required

filetype plugin on
filetype indent on

let mapleader = ','


set history=1000
set autoread
set ruler
set rnu

set textwidth=79
set colorcolumn=80
set wrap
set linebreak

set noerrorbells
set novisualbell

set cursorline
set showmatch
set hlsearch

set list
set listchars=tab:▹\ ,trail:▵

" pum: PopUp Menu, the menu by <C-N> in insert mode
set pumheight=16

" keep space from top and bottom
set scrolloff=2

set wildmenu
set wildignore=*.o,*~,*.pyc

syntax on
set t_Co=256
silent! color luthadel

" don't redraw while executing macros (good performance config)
set lazyredraw

" gt: next tab
" gT: previous tab
set tabpagemax=100
noremap <Leader>t :tabedit <C-R>=expand('%:p:h')<CR>/
" ,1 ,2 ,3: go specific tab
for i in range(1, 9)
    exec 'noremap <Leader>'.i.' '.i.'gt'
endfor

" ,v: split vertically
" ,h: split horizontally
set splitright
noremap <silent> <Leader>v :vsplit<CR>
noremap <silent> <Leader>h :split<CR>


set incsearch
" use /\C to overrule it
set ignorecase
" be case-sensitive when contains upper char
set smartcase

set autoindent

set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" don't backup
set nobackup
set nowb
set noswapfile

set encoding=utf-8

autocmd FileType html
    \ noremap <Leader>i1 i<!DOCTYPE html><CR><html lang="en"><CR><head><CR><meta charset="UTF-8"><CR><title></title><CR></head><CR><body><CR><CR></body><CR></html>

let g:coc_confing_home = '~/yuan-vim/coc-settings.json'
let g:coc_global_extensions = ['coc-json', 'coc-html', 'coc-go', 'coc-css', 'coc-clangd','coc-tailwindcss','coc-prettier', 'coc-sh' ]

map <F3> :NERDTreeToggle<CR>
let g:NERDTreeWinPos="right"

" "[registers]yy

"<C-U> / <C-D>	Half-page up/down
"<C-B> / <C-F>	Page up/down
"<C-e> / <C-y>	Move screen up/down
"
"zt zz zb Scrolls to top/middle/bottom
