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

" WSL から yank した内容を Windows のクリップボードへ送る
function! s:copy_to_windows_clipboard() abort
  if v:event.operator !=# 'y' || index(['', '+', '*'], v:event.regname) < 0
    return
  endif

  let l:text = join(v:event.regcontents, "\n")
  if v:event.regtype ==# 'V'
    let l:text .= "\n"
  endif
  " NUL バイトを含む UTF-16LE は Vim の文字列を経由せずに渡す
  call system('iconv -f UTF-8 -t UTF-16LE | clip.exe', l:text)
endfunction

augroup wsl_clipboard
  autocmd!
  if executable('clip.exe') && executable('iconv') && exists('##TextYankPost')
    autocmd TextYankPost * call s:copy_to_windows_clipboard()
  endif
augroup END

set autoindent
set smartindent
