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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'chrisbra/csv.vim'

"theme
Plug 'morhetz/gruvbox'

"for web development
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'
Plug 'posva/vim-vue'

" All of your Plugs must be added before the following line
call plug#end()            " required

colorscheme gruvbox

filetype plugin on
filetype indent on

let mapleader = ','


set history=1000
set autoread
set ruler
set nu
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
set fileencodings=utf-8,cp950,iso-2022-jp,euc-jp,sjis,ucs-bom,default,latin1
set guifont=Fira\ Code:h12

autocmd FileType html
    \ noremap <Leader>i1 i<!DOCTYPE html><CR><html lang="en"><CR><head><CR><meta charset="UTF-8"><CR><title></title><CR></head><CR><body><CR><CR></body><CR></html>

autocmd FileType c
            \ noremap <Leader>i1 i#include <stdio.h><CR><CR>void main(int argc, char **argv){<CR>printf("hello world");<CR>}

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-tailwindcss',
  \ 'coc-vetur',
  \ 'coc-go',
  \ 'coc-yaml',
  \ ]
" from readme

let g:go_def_mapping_enabled = 0
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=200
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

autocmd FileType vue syntax sync fromstart

autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gtc :CocCommand go.tags.clear<cr>
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

map <F3> :NERDTreeToggle<CR>
let g:NERDTreeWinPos="right"

let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_section_b = system("git rev-parse --abbrev-ref HEAD")


"let g:Hexokinase_highlighters = [ 'sign_column' ]
"let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript']

" "[registers]yy

"<C-U> / <C-D>	Half-page up/down
"<C-B> / <C-F>	Page up/down
"<C-e> / <C-y>	Move screen up/down

"zt zz zb Scrolls to top/middle/bottom

" f t ;
