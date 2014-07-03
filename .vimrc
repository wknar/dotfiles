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
set history=1000
set laststatus=2
set directory=/tmp
set backspace=indent,eol,start
set wildmenu
set wildmode=full
set tabstop=2
set shiftwidth=2
set expandtab

set syntax=on

colorscheme slate

vnoremap * "zy:let @/ = @z<CR>n"
let g:netrw_liststyle=3

set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'tpope/vim-rails'

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

runtime macros/matchit.vim

" hl_matchit settings
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'Title'
let g:hl_matchit_allow_ft = 'html\|vim\|ruby\|sh'

if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif

augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

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
