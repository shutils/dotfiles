scriptencoding utf-8
" コピー系
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P
nnoremap <Leader>r diw"0P

" ウィンドウ操作系
nnoremap <Leader>o <C-w><C-w>
nnoremap <Leader>ss <C-w>s
nnoremap <Leader>sv <C-w>v
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" 移動系
inoremap <C-b> <LEFT>
inoremap <C-f> <RIGHT>
noremap H ^
noremap L $
noremap J 5j
noremap K 5k

" 特殊
nnoremap <Leader>_ :source $MYVIMRC<CR>

" ファイル操作
nnoremap <Leader>w :w<CR>

set clipboard=unnamedplus
set autoindent
set smartindent
