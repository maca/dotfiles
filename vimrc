call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible                  " Must come first because it changes other options.

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.
filetype plugin on                " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set encoding=utf-8                " Use UTF-8 everywhere.
set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set foldmethod=syntax             " Folding for syntax

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs

set autoread                     " Reload files edited outside vim
set formatprg=par                " Use par to format paragraphs

" setglobal relativenumber
autocmd BufRead,WinEnter * :setlocal relativenumber
autocmd WinLeave,FocusLost * :setlocal number
autocmd InsertEnter * :setlocal number
autocmd InsertLeave * :setlocal relativenumber

function! g:ToggleNuMode()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

map <C-l> :call g:ToggleNuMode()<CR>

" Bring vim to front when a file is read
function! g:BringVimToFront()
  if v:servername == "STANDALONE"
    silent !echo "run_or_raise.run_or_raise('/bin/sh', {instance = 'vim'})" | awesome-client &
    redraw!
  endif
endfunction

autocmd BufRead,TabEnter,RemoteReply * :call g:BringVimToFront()


" Controversial...replace colon by semicolon for easier commands
nmap ; :
vmap ; :

" set paragraph formatter program to par
set formatprg=par

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

set term=xterm-256color
set t_Co=256

" Map leader to ,
let mapleader = ","
let g:mapleader = ","

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Tabularize mappings
map <Leader>t= :Tabularize /=<CR>
map <Leader>t: :Tabularize /:<CR>
map <Leader>t> :Tabularize /=>:<CR>

" Ctag mappings
map gt <C-]>
map gs :ptselect
map gb :pop<CR>
map <C-W>gt <C-W><C-]>
map <Leader>lt :TlistOpen<CR>

" Switch between two files
nnoremap ,, <C-^>
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" Manual folding on insert, back to defined on exit insert.
autocmd FileType ruby setlocal foldmethod=syntax
autocmd InsertEnter * let w:fdm=&foldmethod | setlocal foldmethod=manual
autocmd InsertLeave * let &l:foldmethod=w:fdm

" Folding for coffe
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

" auto reload .vimrc after editing
autocmd BufWritePost .vimrc source $MYVIMRC

" quick escape
imap jj <Esc>

colorscheme desert-alt

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
    set guifont=Inconsolata:h12
    set linespace=4
    set transparency=15
    set lines=160 columns=340          " Window dimensions.
    set fu
  endif
endif

" system copy/paste
vmap <leader>y "+y
nmap <leader>p "+gP

" history tree
nnoremap ,h :GundoToggle<CR>
nnoremap <C>P :CtrlPBuffer

" Cycle through panes with space
map <Space> <c-W>w
" Jump to new pane when created
nnoremap <C-w>s <C-w>s<C-w>j
nnoremap <C-w>v <C-w>v<C-w>l
" Alias window mappings for tmux consistency
map <C-a> <C-w>

match Todo /\s\+$/

" New line on Enter on normal mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
