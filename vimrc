set nocompatible                  " Must come first because it changes other options.
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'ElmCast/elm-vim'
Plugin 'KabbAmine/vCoolor.vim'
Plugin 'KabbAmine/zeavim.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Townk/vim-autoclose'
Plugin 'airblade/vim-rooter'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'elixir-lang/vim-elixir'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular.git'
Plugin 'hail2u/vim-css3-syntax.git'
Plugin 'juvenn/mustache.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
Plugin 'mattn/gist-vim'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'slim-template/vim-slim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/ZoomWin'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/vim-coffee-script'

call vundle#end()            " required


filetype plugin indent on         " Turn on file type detection.
syntax enable                     " Turn on syntax highlighting.

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

set relativenumber
set number                       " Show line numbers.
set lazyredraw                   " Fixes relativenumber slow scroll

set mouse=n                      " Mouse normal

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

" move un and down regardless of line
nmap j gj
nmap k gk

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

set term=xterm-256color
set t_Co=256

" Map leader to ,
let mapleader = ","
let g:mapleader = ","

" Search word under cursor
noremap <Leader>a :Ack <cword><cr>

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
map gs :ptselect<CR>
map gb :pop<CR>
map <Leader>gl :TlistOpen<CR>

nnoremap <Leader>. :CtrlPBuffer<CR>
nnoremap <Leader>.. :CtrlPTag<CR>
nnoremap <Leader>... :TagbarToggle<CR>


" Switch between two files
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" Manual folding on insert, back to defined on exit insert.
autocmd FileType ruby setlocal foldmethod=syntax
autocmd InsertEnter * let w:fdm=&foldmethod | setlocal foldmethod=manual
autocmd InsertLeave * let &l:foldmethod=w:fdm

" Folding for coffe
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

" quick escape
imap jj <Esc>

colorscheme desert-alt

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

" VCoolor
let g:vcoolor_lowercase = 1
map <C-c> :VCoolor<CR>

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%82v', 100)

set list listchars=tab:>-,trail:.,precedes:<,extends:>

let g:ackprg = 'ag --vimgrep'

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|public\|data\|log\|tmp\|node_modules\|vendor$',
  \ }
