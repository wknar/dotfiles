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
set noswapfile
set wildmode=list:full
if exists("&wildignorecase")
  set wildignorecase
endif

" move cursor like bash in command mode
cnoremap <C-b> <LEFT>
cnoremap <C-f> <RIGHT>

vnoremap * "zy:let @/ = @z<CR>n"
let g:netrw_liststyle=10

" treeview
nnoremap ep :Vexplore

" same width window
nnoremap == <C-w>=

" tab transfer
nnoremap er gt
nnoremap ew gT

" tweetvim
cnoremap twh TweetVimHomeTimeline
cnoremap twu TweetVimUserTimeline
cnoremap twt TweetVimCommandSay
cnoremap tws TweetVimSearch
nmap <silent> <buffer> <leader>f  <Plug>(tweetvim_action_favorite)
nmap <silent> <buffer> <leader>F  <Plug>(tweetvim_action_favstar)

" open ctag in tab/vertical split
map <C-]> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/,/usr/share/vim/vim{$vim_version}
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundleCheck
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'tpope/vim-rails'
" tweet vim plugins
NeoBundle 'basyura/TweetVim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'mattn/favstar-vim'
call neobundle#end()

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

syntax enable
set background=dark

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

" md as markdown, instead of modula2
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*,txt} set filetype=markdown
autocmd BufNewFile,BufRead Gemfile set filetype=ruby

autocmd BufNewFile,BufRead *.tx set filetype=html

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
