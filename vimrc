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

" Clolor Scheme {
  set title
  set number
  set cursorline
  syntax enable
  colorscheme delek            "color schoe 
  let g:solarized_termcolors=256
" }

" General Setting
  let mapleader = ","
  set history=1000
  set ruler
  set autoread

  filetype off
  syntax on
  filetype on
  filetype indent on
  filetype plugin on

  set hlsearch

  set clipboard=unnamed
  set showmatch
  set wildchar=<TAB>
  set wildmenu
  set wildignore=*.o,*.class,*.pyc

  set autoindent
  set incsearch
  set nobackup
  set ignorecase
  set smartcase
  set smarttab

  set noerrorbells
  set novisualbell
  set tm=500

  " 摺疊設置 {
    set foldmethod=syntax " 用語法高亮來定義摺疊
    set foldlevel=100     " 啟動vim時不要自動摺疊代碼
  " }

  " TAB Setting{
    set expandtab
    set tabstop=2
    set shiftwidth=2
    au FileType Makefile set noexpandtab
  " }

  " C/C++ specific settings
  autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

" }

" Encoding Setting {
  set encoding=utf-8                                  
  set termencoding=utf-8
  set fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1
  if &term =~ 'screen'
    set t_Co=256
  endif
" }

" Plugin Setting {

  " PowerLine {
    let g:Powerline_symbols = 'unicode'
    set laststatus=2
  " }

  " NERDTree {
    map <F6> :NERDTreeToggle<CR>
    let g:NERDTreeWinPos="right"
  " }

  " taglist {
    map <F5> :Tlist<CR>
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
