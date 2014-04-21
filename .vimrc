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

vnoremap * "zy:let @/ = @z<CR>n"
let g:netrw_liststyle=3

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

  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/neocomplcache'
  NeoBundle 'thinca/vim-ref'
  NeoBundle 'vimtaku/hl_matchit.vim.git'
  NeoBundle 'vim-ruby/vim-ruby'

  filetype indent plugin off
  syntax on
  colorscheme slate
endfunction

call s:InitNeoBundle()

runtime macros/matchit.vim

" hl_matchit settings
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'Title'
let g:hl_matchit_allow_ft = 'html\|vim\|ruby\|sh'


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
