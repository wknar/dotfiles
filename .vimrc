set filetype=on
set nocompatible
set wrap
set ignorecase
set smartcase
set notitle
set hlsearch
set autowrite
set scrolloff=5
set showmatch
set nobackup
set number
set noautoindent
set history=50
set laststatus=2
set directory=/tmp
set backspace=indent,eol,start
set wildmenu
set wildmode=full

set syntax=on
set background=dark

vnoremap * "zy:let @/ = @z<CR>n"

" NeoBundle settings
function! s:WithoutBundles()
  colorscheme desert
endfunction

function! s:LoadBundles()
  NeoBundle 'Shougo/neobundle.vim'
  NeoBundle 'tpope/vim-surround'
endfunction

function! s:InitNeoBundle()
  if isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    filetype plugin indent off
    if has('vim_starting')
      set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif
    try
      call neobundle#rc(expand('~/.vim/bundle/'))
      call s:LoadBundles()
    catch
      call s:WithoutBundles()
    endtry 
  else
    call s:WithoutBundles()
  endif

  filetype indent plugin on
  syntax on
endfunction

call s:InitNeoBundle()


" cakephp function auto update
function! NewUpdate()
  let time = strftime("%H", localtime())
  exe "set backupext=.".time
  if expand('%') =~ g:svbfre && !&readonly && &buftype == ''
    silent! update
  endif
endfunction

let g:cakephp_enable_auto_mode = 1
autocmd BufNewFile,BufRead *.ctp set filetype=php

let g:cakephp_log = {
\ 'query' : '/var/log/mysqld/sql.log'
\}
