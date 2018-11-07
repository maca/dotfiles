
" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'lifepillar/vim-mucomplete'
Plug 'ElmCast/elm-vim'
Plug 'KabbAmine/zeavim.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'airblade/vim-rooter'
Plug 'elixir-lang/vim-elixir'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'idris-hackers/idris-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'lifepillar/vim-mucomplete'

call plug#end()


filetype plugin indent on         " Turn on file type detection.
syntax enable                     " Turn on syntax highlighting.

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

set foldmethod=indent             " Folding for indent (syntax slows down for big files)

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.

set directory=~/.vim/swap,/tmp    " Keep swap files in one location
set backupdir=~/.vim/backup,/tmp
set undodir=~/.vim/undo,/tmp
set undofile                     " Persist undo across sessions

set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs

set autoread                     " Reload files edited outside vim
set formatprg=par                " Use par to format paragraphs

set relativenumber
set number                       " Show line numbers.
set lazyredraw                   " Fixes relativenumber slow scroll

set mouse=n                      " Mouse normal

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
map <leader>t= :Tabularize /=<CR>
map <leader>t: :Tabularize /:<CR>
map <leader>t> :Tabularize /=>:<CR>


" Ctag mappings
map gt <C-]>


" quick escape
imap jj <Esc>


" history tree
nnoremap <Leader>h :GundoToggle<CR>


set list listchars=tab:>-,trail:.,precedes:<,extends:>


" Easymotion
map <leader> <plug>(easymotion-prefix)


" <leader>f{char} to move to {char}
map  <leader>f <plug>(easymotion-bd-f)
nmap <leader>f <plug>(easymotion-overwin-f)


" File navigation and search
nmap <space>f :FZF<cr>
nmap <space>F :History<cr>
nmap <space>b :Buffers<cr>
nmap <space>a :call fzf#vim#ag(expand('<cword>'))<cr>
nmap <space>A :Ag<cr>
nmap <space>t :call fzf#vim#tags(expand('<cword>'))<cr>
nmap <space>T :Tags<cr>
nmap <Space>pt :TagbarOpen<CR>
nmap <space>pp :reg<CR>

let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1


" system copy/paste
vmap <leader>y "+y
nmap <leader>p "+gP


" Jump to new pane when created
nnoremap <c-w>s <c-w>s<c-w>j
nnoremap <c-w>v <c-w>v<c-w>l
map <c-a> <c-w>
map <space>z :ZoomToggle<cr>


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


" Autocomplete
filetype plugin on
set noinfercase
set completeopt+=menuone,noselect,preview
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion
set omnifunc=syntaxcomplete#Complete
set tags=./tags
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#minimum_prefix_length = 1
let g:mucomplete#chains = {}
let g:mucomplete#chains.default  = ['path', 'incl', 'tags', 'omni']
imap <expr> <right> mucomplete#extend_fwd("\<right>")


