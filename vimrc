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
Plugin 'vim-scripts/OmniCppComplete'
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
Plugin 'airblade/vim-gitgutter'
Plugin 'Yggdroot/indentLine'
Plugin 'yegappan/grep'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'aceofall/gtags.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" 顏色配置 {
set title
set number             " 顯示行號
set cursorline         " 所在行高亮度
set list lcs=tab:\|\   " 以 | 來顯示 Tab
syntax enable
colorscheme desert
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
map <F12> :!astyle --style=kr --indent=spaces=4 --indent-switches --suffix=none -S -M -Y -xe -k3 -W3 -j -xL -p % <CR>
"auto remove tailing space
autocmd BufWritePre * :%s/\s\+$//e
set listchars=trail:⎵
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
:inoremap ( ()<LEFT>
:inoremap " ""<LEFT>
:inoremap ' ''<LEFT>
:inoremap { {}<LEFT>
:inoremap [ []<LEFT>
:inoremap < <><LEFT>
" }

" Tags 設定
set tags=tags;
set autochdir
"}

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
map <F4> :TlistToggle<CR>
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

" indentLine Setting {
let g:indentLine_color_term = 239
" }

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" global Setting{
set cscopetag
set cscopeprg='gtags-cscope'
let GtagsCscope_Auto_Load=1
let GtagsCscope_Auto_Map=0
let GtagsCscope_Quiet=1
nmap css :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap csg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap csc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap cst :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap cse :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap csf :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap csi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap csd :cs find d <C-R>=expand("<cword>")<CR><CR>

map <C-F11> :global -i <CR>
function! LoadDatabase()
    let db = findfile("GTAGS", ".;")
    if (!empty(db))
        set nocscopeverbose
        exe "cs add " . db
        set cscopeverbose
    endif
endfunction
function! UpdateGtags(f)
    let dir = fnamemodify(a:f, ':p:h')
    exe 'silent !cd ' . dir . ' && global -u &> /dev/null &'
endfunction
autocmd BufEnter *.[ch] call LoadDatabase()
autocmd BufWritePost *.[ch] call UpdateGtags(expand('<afile>'))
"}

" Doxygen{
let g:DoxygenToolkit_briefTag_pre="@brief "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@return "
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Hua-Yuan"
"let g:DoxygenToolkit_licenseTag="My own license"
nmap df : Dox <CR>
nmap db : DoxBlock <CR>
nmap da : DoxAuthor <CR>
nmap dl : DoxLic <CR>
"}
