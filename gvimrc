" Example Vim graphical configuration.
" Copy to ~/.gvimrc or ~/_gvimrc.

set antialias                     " MacVim: smooth fonts.
set guioptions-=T                 " Hide toolbar.
set guioptions-=l " No left scrollbar
set guioptions-=L " .. even if vertical split
set guioptions-=r " No right scrollbar
set guioptions-=b " No bottom scrollbar
" set background=light              " Background.

noremap i :highlight Normal guibg=#2F0804<cr>i
noremap o :highlight Normal guibg=#2F0804<cr>o
noremap s :highlight Normal guibg=#2F0804<cr>s
noremap a :highlight Normal guibg=#2F0804<cr>a
noremap I :highlight Normal guibg=#2F0804<cr>I
noremap O :highlight Normal guibg=#2F0804<cr>O
noremap S :highlight Normal guibg=#2F0804<cr>S
noremap A :highlight Normal guibg=#2F0804<cr>A

"You need the next line to change the color back when you hit escape.
"
inoremap <Esc> <Esc>:highlight Normal guibg=black<cr> 
