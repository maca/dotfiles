" Example Vim graphical configuration.
" Copy to ~/.gvimrc or ~/_gvimrc.

set antialias                     " MacVim: smooth fonts.
set encoding=utf-8                " Use UTF-8 everywhere.
set guioptions-=T                 " Hide toolbar.
set guioptions-=l " No left scrollbar
set guioptions-=L " .. even if vertical split
set guioptions-=r " No right scrollbar
set guioptions-=b " No bottom scrollbar
" set background=light              " Background.

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Monospace\ 9
  elseif has("gui_photon")
    set guifont=Monospace:9
  elseif has("gui_kde")
    set guifont=Monospace/9/-1/5/50/0/0/0/1/0
  elseif has("x11")
    set guifont=-*-monospace-medium-r-normal-*-*-180-*-*-m-*-*
  else
    set guifont=Inconsolata:h16
    set linespace=3
    set transparency=15
      set lines=60 columns=240          " Window dimensions.
  endif
endif

" nmap <F2>:let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) - 1)', '')<CR> 
" nmap <F3>:let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) + 1)', '')<CR> 
colorscheme ir_black

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
