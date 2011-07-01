"Use vim
set nocompatible

"backgroundは明るいと教えてあげる
" light or black
set background=light

"配色の指定
colorscheme desert

"これを書かない意味が分からない
filetype plugin indent on

" 強調表示（色）on or off
syntax on

"モードラインを有効にする
"デフォルトでは上下5行だけ探しにいく
" 例 C言語ファイルの場合
" /* vim: set expandtab ft=txt */
set modeline
set modelines=3


"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>


augroup Binary
  autocmd!
  autocmd BufReadPre  *.bin let &bin=1
  autocmd BufReadPost * if &bin | silent %!xxd -g 1
  autocmd BufReadPost * set filetype=xxd | endif
  autocmd BufWritePre * if &bin | %!xxd -r
  autocmd BufWritePost * if &bin | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END


"vimを使ってくれてありがとう問題に対処
set title

" number(行数)を表示
set number

"一行に長い文章を書いていても
"自動折り返しをしない
set textwidth=0
"画面端で行を折り返して表示
set wrap

"backupファイルを作らない
"set nobackup
"やっぱり作る
"以下の設定で.vim-backupに*~や*.swpファイルができる
" $ mkdir $HOME/.vim-backup とやる必要があり
"set backup
"set backupdir=$HOME/.vim-backup
"let &directory = &backupdir
"やっぱいらない

"コマンド、検索パターンの履歴数
set history=1000

"加減算コマンドCtrl+a,Ctrl+x
"alpha アルファベット
"octal 8進数
"hex   16進数
set nrformats+=alpha
set nrformats+=octal
set nrformats+=hex

"カーソルが何行目の何列目に置かれているか表示する
"でも、statuslineで指定しているので意味ないのかと
"set ruler

"poweful backspace
"backspaceの挙動を強化する
"indentはオートインデントの空白文字を削除できる
"eolは行の先頭で<BS>を押すと前の行の改行文字を削除できる
"startはC+uやC+wで入力した文字以外（最初から行にある文字）も削除できる
set backspace=indent,eol,start

"%での移動に<>も追加
"下の3つはdefaultで移動可能
"{}
"[]
"()
set matchpairs+=<:>

"自動でindentしてくれる
"autoindentとcindentがあるが
"個人的にはsmartindentが一番賢いと思ってる
"set smartindent

" タブの代わりに空白を
set expandtab
" 自動インデントのスペース数
set shiftwidth=2
" タブを入力したのときのスペース数
set tabstop=2
" タブを削除するときに
set softtabstop=2

" 現在のmodeを表示
" ビジュアル?
" 挿入？
" コマンド?
set showmode

" 対応する括弧に一時的に移動する
" たとえば（と入力してから）を入力すると
" （に一時的にカーソルが移動する
" ）に戻ってくるまでの時間は
" オプションmatchtimeで指定可能
set showmatch
" (値/10)秒
set matchtime=5

" コマンドを表示する
set showcmd

"補間候補の表示
set wildmenu


" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索が末尾まで行ったら先頭へ戻る
"set wrapscan
set nowrapscan
" インクリメンタルサーチ
set incsearch
" 検索結果をハイライト
set hlsearch
"ハイライト残ってると気が散るのでさようなら
nnoremap <C-k><C-k> :nohlsearch<CR><Esc>

"表示行単位で移動してくれる
"1行が長い場合に便利だったりする
"nnoremap j gj
"nnoremap k gk
"見ている行が真ん中にくる
nnoremap j gjzz
nnoremap k gkzz

" ステータスラインを表示
" 2に設定するといつでも表示
set laststatus=2
" 表示する内容の編集
set statusline=\ [%02n]                                        "number of buffer
set statusline+=\ %F                                           "file name
set statusline+=\ %7(%m\ %r%)                                  "読み込み専用ファイルはRO,変更されたら+とか
set statusline+=%{&fileencoding}\ %{&fileformat}\ %{&filetype}
set statusline+=%=\ (%l,%c)                                    "行、列表示
set statusline+=%=\ \ \ [%b,0x%B]                              "ascii文字コード表示


" 前回終了したカーソル行に移動
" 最近のvimでは設定しなくてもdefaultらしいけど一応
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif


"Shiftを使った画面移動
nnoremap <S-h> <C-W>h
nnoremap <S-j> <C-W>j
nnoremap <S-k> <C-W>k
nnoremap <S-l> <C-W>l


"skeltonファイルの読み込み
"面倒な記述をしてもらう
"silentは下に表示されるメッセージを無視
autocmd BufNewFile *.pl    silent 0r ~/.vim/skelton/sk.pl
autocmd BufNewFile *.c     silent 0r ~/.vim/skelton/sk.c
autocmd BufNewFile *.rb    silent 0r ~/.vim/skelton/sk.rb
"zsh関数ファイルのファイルタイプをzshに
autocmd BufNewFile,BufReadPost ~/.zfunc/* :set ft=zsh
autocmd BufNewFile,BufReadPost *.cgi      :set ft=ruby
"autocmd BufNewFile,BufReadPost *.plogic   :set ft=css



"キーボード
nnoremap ; :
"shellへの移動を簡単に
nnoremap ,, <C-z>
"escは打ちにくいので
inoremap <C-k> <esc>

"bufferが編集中でも他のファイルが開ける
set hidden
"外部のeditorで変更されたら自動でfileを読み直す
set autoread

"全角スペースを目立たせる
"以下の設定だと赤い下線になる
highlight ZenkakuSpace cterm=underline ctermfg=red guibg=white
match ZenkakuSpace /　/


""""""""""MiniBufExp""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""
"Spaceでbuffer移動
nnoremap <Space> :bn<CR>
" minibufexpl.vimの変数
"こう書けと言われた
"調べたい
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplSplitBelow = 0
let g:miniBufExplSplitToEdge = 1
""""""""""""""""""""""""""""""""""""""""


"file exploreを開いてくれるけど
"あんまり使ってない
"map <C-W><C-V> :Vexplore!<CR>
"map <C-W><C-H> :Hexplore<CR>
"map! <C-W><C-V> <Esc>:Vexplore!<CR>
"map! <C-W><C-H> <Esc>:Hexplore<CR>

"plugin YankRing.vimの利用のため
"前は使ってたけど、今はない
"nmap ,y :YRShow<CR>



"以下は補間の優先順位の設定
"~/.vim/dictに自分で作った辞書ファイルとかも置ける
autocmd Filetype *    let g:AutoComplPop_CompleteOption='.,w,b,u,t,i'
autocmd Filetype java let g:AutoComplPop_CompleteOption='.,w,b,u,t,i,k~/.vim/dict/j2se14.dict'
autocmd Filetype c    let g:AutoComplPop_CompleteOption='.,w,b,u,t,i,k~/.vim/dict/c.dict'



""""""""NeoComplCache"""start""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplcache_enable_at_startup = 1
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"有効にしたり無効にしたり
inoremap ,s <ESC>:NeoComplCacheEnable<CR>a
inoremap ,q <ESC>:NeoComplCacheDisable<CR>a
nnoremap ,s :NeoComplCacheEnable<CR>
nnoremap ,q :NeoComplCacheDisable<CR>
"補間バーの色設定
highlight Pmenu     ctermbg=4
highlight PmenuSel  ctermbg=1
highlight PMenuSbar ctermbg=4
"autocmd Filetype vim     let g:neocomplcache_CompleteOption='.,w,b,u,t,i,k~/.vim/dict/c.dict'
"autocmd Filetype vim     let g:neocomplcache_plugin_rank='.,w,b,u,t,i'
"autocmd Filetype vim     let g:neocomplcache_plugin_rank={.}
"autocmd Filetype vim     let g:neocomplcache_plugin_rank={'.'}
"autocmd Filetype vim     let g:neocomplcache_plugin_rank={"."}
"autocmd Filetype vim     let g:neocomplcache_plugin_rank={}
"autocmd Filetype vim     let g:neocomplcache_plugin_rank={'syntax_complete':1}
autocmd Filetype vim     let g:neocomplcache_plugin_rank={'buffer_complete':1}
""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""NeoComplCache"""""""end"""""""""""""""""""""


imap <silent> <C-l> <Plug>(neocomplcache_snippets_expand)


set fileencodings=utf-8,cp932

