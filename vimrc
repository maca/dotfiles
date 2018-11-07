set nocompatible " Must come first because it changes other options.
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


Plugin 'VundleVim/Vundle'
Plugin 'lifepillar/vim-mucomplete'
Plugin 'ElmCast/elm-vim'
Plugin 'KabbAmine/zeavim.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'airblade/vim-rooter'
Plugin 'elixir-lang/vim-elixir'
Plugin 'godlygeek/tabular.git'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'idris-hackers/idris-vim'
Plugin 'ludovicchabant/vim-gutentags'

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

set nowrap                        " Turn off line wrapping.
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

autocmd BufRead,BufNew *.elm :setlocal foldmethod=indent

" Controversial...replace colon by semicolon for easier commands
map ; :

" move un and down regardless of line
nmap j gj
nmap k gk


set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P


" Color and highlighting
set term=xterm-256color
set t_Co=256
colorscheme desert-alt
set colorcolumn=64,80
highlight ColorColumn ctermbg=100
match Todo /\s\+$/


" Map leader to ,
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ",,"


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


" quick escape
imap jj <Esc>


" system copy/paste
vmap <leader>y "+y
nmap <leader>p "+gP


" history tree
nnoremap ,h :GundoToggle<CR>


" New line on Enter on normal mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>


set list listchars=tab:>-,trail:.,precedes:<,extends:>


" Easymotion
map <Leader> <Plug>(easymotion-prefix)


" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)


" File navigation and search
let g:ctrlp_switch_buffer = 'vh' " ctrlp will open in buffer
nmap <Leader>a :Ack <cword><CR>
nmap <Space>f :CtrlPMixed<CR>
nmap <Space>b :CtrlPBuffer<CR>
nmap <Space>t :CtrlPTag<CR>
nmap <Space>tt :TagbarToggle<CR>


" Window commands with space
map <Space> <c-W>
" Jump to new pane when created
nnoremap <C-w>s <C-w>s<C-w>j
nnoremap <C-w>v <C-w>v<C-w>l
map <C-a> <C-w>
map <Space>z :ZoomToggle<CR>


" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()


" Ack configuration
let g:ackprg = 'ag --vimgrep'
if executable('ag')
  " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast, respects .gitignore
  " and .agignore. Ignores hidden files by default.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -f -g ""'
else
  "ctrl+p ignore files in .gitignore
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
endif

" Autocomplete
filetype plugin on
set noinfercase
set completeopt+=menuone,noselect,preview
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion
set omnifunc=syntaxcomplete#Complete
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#minimum_prefix_length = 1

