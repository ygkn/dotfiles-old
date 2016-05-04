set number
set t_Co=256
"Tabをスペース4つに展開＆Tabの設定
set tabstop=4
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
set expandtab
set shiftwidth=4
set nocompatible
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" ここに入れたいプラグインを記入
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'kana/vim-submode'
" syntax + 自動compile
NeoBundle 'kchmck/vim-coffee-script'
" js BDDツール
NeoBundle 'claco/jasmine.vim'
NeoBundle 'itchyny/lightline.vim'

NeoBundle 'hail2u/vim-css3-syntax'
"NeoBundle 'taichouchou2/vim-javascript'
NeoBundle 'moll/vim-node'

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" tab through emmet fields
function! s:move_to_next_emmet_area(direction)
  " go to next item in a popup menu
  if pumvisible()
    if (a:direction == 0)
      return "\<C-p>"
    else
      return "\<C-n>"
    endif
  endif

  " try to determine if we're within quotes or angle brackets.
  " if so, assume we're in an emmet fill area.
  let line = getline('.')
  if col('.') < len(line)
    let line = matchstr(line, '[">][^<"]*\%'.col('.').'c[^>"]*[<"]')

    if len(line) >= 2
      if (a:direction == 0)
        return "\<Plug>(emmet-move-prev)"
      else
        return "\<Plug>(emmet-move-next)"
      endif
    endif
  endif

  " return a regular tab character
  return "\<tab>"
endfunction

" expand an emmet sequence like ul>li*5
function! s:expand_emmet_sequence()
  " first try to expand any neosnippets
  if neosnippet#expandable_or_jumpable()
    return "\<Plug>(neosnippet_expand_or_jump)"
  endif

  " expand anything emmet thinks is expandable
  if emmet#isExpandable()
    return "\<Plug>(emmet-expand-abbr)"
  endif
endfun

" using <C-s> requires a line in .bashrc/.zshrc/etc. to prevent
" linux terminal driver from freezing the terminal on ctrl-s:
"     stty -ixon -ixoff
" see: http://unix.stackexchange.com/questions/12107/how-to-unfreeze-after-accidentally-pressing-ctrl-s-in-a-terminal#12108
" also: http://stackoverflow.com/questions/6429515/stty-hupcl-ixon-ixoff
autocmd FileType html,hbs,handlebars,css,scss imap <buffer><expr><C-s> <sid>expand_emmet_sequence()
autocmd FileType html,hbs,handlebars,css,scss imap <buffer><expr><S-TAB> <sid>move_to_next_emmet_area(0)
autocmd FileType html,hbs,handlebars,css,scss imap <buffer><expr><TAB> <sid>move_to_next_emmet_area(1)


set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat'
      \ }

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 自動的に閉じ括弧を入力
""""""""""""""""""""""""""""""
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
""""""""""""""""""""""""""""""

" カーソルが何行目の何列目に置かれているかを表示する
set ruler

" ウインドウのタイトルバーにファイルのパス情報等を表示する
set title
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu

" 検索結果をハイライト表示する
set hlsearch



nnoremap <silent><C-e> :NERDTreeToggle<CR>

" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデントを設定
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

nnoremap <F3> :noh<CR>

" Tab & Window関連
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

