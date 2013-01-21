filetype plugin on
filetype indent off

" -------------------
" Language
" -------------------
set encoding=utf-8
set fileencodings=iso-2002-jp,utf-8,euc-jp,cp932

" -------------------
" Explore
" -------------------
let g:explHideFiles='^\.,\.gz$,\.exe$,\.zip$'
let g:explDetailedHelp=0
let g:explWinSize=''
let g:explSplitBelow=1
let g:explUseSeparators=1

" -------------------
" Buffer
" -------------------
set hidden "保存しないで他のファイルを表示する

" -------------------
" other
" -------------------
set nocompatible "コマンドモードをタブで補完できるようになる
set wrap "行の端まで到達すると折り返す
set ignorecase "検索時に大文字と小文字を区別しない
set smartcase "検索時に大文字と小文字を区別しない
set notitle "[Thanks for flying vim]を消す(らしいけどいらなそう)
set hlsearch "検索結果をハイライト表示する
set autowrite "自動的にファイルを保存する
set scrolloff=5 "カーソルの上下に表示する最小限の行数
set showmatch "閉じ括弧が入力された時に対応する括弧を表示する
set nobackup "バックアップファイルをつくるのを止めさせる
set number "行番号を表示する
set noautoindent "テキストの整形処理をしない 
set history=50 "コロンコマンドを記録する数
set list "Listモードに使われる文字を設定する
set listchars=tab:\ \ ,extends:<,trail:\ 
set laststatus=2 "末尾から2行目にステータスラインを表示する
set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L "ステータス行の表示
set directory=/tmp "スワップファイルの出力先
set backspace=indent,eol,start "BSキーでインデントを削除
set wildmenu
set wildchar=<Tab>
set wildmode=full "補完動作の設定 full: 次のマッチを完全に補完

au  BufEnter *   execute ":lcd " . escape(expand("%:p:h"), " #\\")
syntax on
"colorscheme desert
colorscheme mrkn256

"
" -------------------
" winmanager.vim 用
" -------------------
let g:bufExplorerOpenMode = 1
let g:bufExplorerSplitBelow = 1
let g:bufExplorerSplitType = 15

map <c-w><c-f> :FirstExplorerWindow<cr>
map <c-w><c-b> :BottomExplorerWindow<cr>
map <c-w><c-t> :WMToggle<cr>

let g:winManagerWindowLayout = 'FileExplorer|TagList'

" -------------------
" 関数の定義
" -------------------
" 自動更新
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

" -----------------------------------------------------------------------------------
" カーソル下の単語を、コントロール押しながらhhっておすと、瞬時にヘルプを引く設定です。
" -----------------------------------------------------------------------------------
nnoremap <C-h> :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>
