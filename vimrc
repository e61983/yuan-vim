set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set shell=/bin/bash

" http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/Vundle.vim
    let iCanHazVundle=0
endif

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/utl.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
" Snippets {
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
" Optional:
Plugin 'honza/vim-snippets'
" }
Plugin 'Rip-Rip/clang_complete'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/gtags.vim'
Plugin 'Yggdroot/indentLine'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" 顏色配置 {
set title
set number             " 顯示行號
set cursorline         " 所在行高亮度
set list lcs=tab:\|\   " 以 | 來顯示 Tab
syntax enable
colorscheme delek 
let g:solarized_termcolors=256
" }

" 一般設定
let mapleader=","      " Leader key
set history=1000       " 歷史記錄長度
set ruler              " 顯示狀態例
set autoread           " 文件被修改時自動重新載入

filetype off
syntax on              " 依據程式語法顯示不同顏色
filetype on            " 文件類型支持
filetype indent on     " 文件類型縮排支持
filetype plugin on     " 文件類型外掛支持

set hlsearch           " 搜尋時高亮度顯示
set backspace=2        " 使 backspace key 正常長處理indent
set clipboard=unnamed  " 與windows共享剪貼板 
set showmatch          " 顯示對應的括號
set wildchar=<TAB>
set wildmenu
set wildignore=*.o,*.class,*.pyc


set incsearch          " 即時搜尋
set nobackup           " 不要產生備份檔
set ignorecase         " 搜尋時乎略大小寫
set smartcase
set smarttab

set noerrorbells       " 關閉錯誤提示音
set novisualbell       " 不閃爍
set tm=500

" 摺疊設置 {
set foldmethod=syntax  " 用語法高亮來定義摺疊
set foldlevel=100      " 啟動vim時不要自動摺疊代碼
" }

" TAB 縮排設定{
set smartindent
set autoindent         " 自動縮排
set cindent
set expandtab
set tabstop=4          " Tab 寬度
set shiftwidth=4       " 縮排字元數
set softtabstop=4
au FileType Makefile set noexpandtab
" }

" C/C++ specific settings
autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

" }

" 編碼設定 {
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1
if &term =~ 'screen'
    set t_Co=256
endif
" }

" 自動括號補齊 {
:inoremap ( ()
:inoremap " ""
:inoremap ' ''
:inoremap { {}
:inoremap [ []
:inoremap ) =ClosePair(')')
:inoremap } =ClosePair('}')
:inoremap ] =ClosePair(']')

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf
" }

" Plugin Setting {

" PowerLine {
let g:Powerline_symbols = 'unicode'
set laststatus=2
" }

" NERDTree {
map <F3> :NERDTreeToggle<CR>
let g:NERDTreeWinPos="right"
" }

" taglist {
map <F4> :Tlist<CR>
" }

" Syntastic Setting {
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0  
" }

" Snipmate Setting {
"}

" Clang Setting {
let g:clang_library_path="/usr/lib/llvm-3.6/lib"
let g:clang_auto_select=1
let g:clang_snippets=1
let g:clang_close_preview=1
let g:clang_user_options = '-std=c99'
" }

" cscope Setting {
set cscopetag
set cscopeprg=gtags-cscope
set cscopequickfix=c-,d-,e-,f-,g0,i-,s-,t-
nmap <silent> <leader>j <ESC>:cstag <c-r><c-w><CR>
nmap <silent> <leader>g <ESC>:lcs f c <c-r><c-w><cr>:lw<cr>
nmap <silent> <leader>s <ESC>:lcs f s <c-r><c-w><cr>:lw<cr>
command! -nargs=+ -complete=dir FindFiles :call FindFiles(<f-args>)
au VimEnter * call VimEnterCallback()
au BufAdd *.[ch] call FindGtags(expand('<afile>'))
au BufWritePost *.[ch] call UpdateGtags(expand('<afile>'))

function! FindFiles(pat, ...)
    let path = ''
    for str in a:000
        let path .= str . ','
    endfor

    if path == ''
        let path = &path
    endif

    echo 'finding...'
    redraw
    call append(line('$'), split(globpath(path, a:pat), '\n'))
    echo 'finding...done!'
    redraw
endfunc

function! VimEnterCallback()
    for f in argv()
        if fnamemodify(f, ':e') != 'c' && fnamemodify(f, ':e') != 'h'
            continue
        endif

        call FindGtags(f)
    endfor
endfunc

function! FindGtags(f)
    let dir = fnamemodify(a:f, ':p:h')
    while 1
        let tmp = dir . '/GTAGS'
        if filereadable(tmp)
            exe 'cs add ' . tmp . ' ' . dir
            break
        elseif dir == '/'
            break
        endif

        let dir = fnamemodify(dir, ":h")
    endwhile
endfunc

function! UpdateGtags(f)
    let dir = fnamemodify(a:f, ':p:h')
    exe 'silent !cd ' . dir . ' && global -u &> /dev/null &'
endfunction
au VimEnter * call VimEnterCallback()
au BufAdd *.[ch] call FindGtags(expand('<afile>'))
au BufWritePost *.[ch] call UpdateGtags(expand('<afile>'))
" }

"gtags Setting {
let g:Gtags_OpenQuickfixWindow = 0 
let g:Gtags_VerticalWindow =  0
let g:Gtags_Auto_Update = 1
let g:Gtags_Auto_Map=0
" }

" indentLine Setting {
let g:indentLine_color_term = 239
" }
"}
