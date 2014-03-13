" 行番号
set number
" 検索履歴を20残す
set history=20
" インクリメントサーチを使用
set incsearch
" 検索語にマッチした単語をハイライト
set hlsearch
" 対になる括弧を強調
set showmatch
" ウインド幅で折り返す
set wrap
" シフト移動幅
set shiftwidth=2
" タブ入力を複数の空白入力に置き換える
set expandtab 
" ファイル内の<Tab>が対応する空白の数
set tabstop=2
" 新しい行に高度なインデントを？
set smartindent
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]


" Color molokai
set t_Co=256
colorscheme molokai
syntax on
let g:molokai_original = 1
let g:rehash256 = 1

" lightline.vim
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }
set laststatus=2

" NeoBundle
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'
" 最高ステータスライン
NeoBundle 'itchyny/lightline.vim'
" :NERDTree でツリーを表示(q 閉じる、o 展開、:help NERD_tree.txt ヘルプ)
NeoBundle 'scrooloose/nerdtree' 

filetype plugin on
filetype indent on


