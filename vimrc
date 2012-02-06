call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible                  " Must come first because it changes other options.

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

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

" UNCOMMENT TO USE
set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

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

" Uncomment to use Jamis Buck's file opening plugin
" map <Leader>f :FuzzyFinderTextMate<Enter>
map <Leader>] <Plug>MakeGreen " change from <Leader>t to <Leader>]

" Fix tmux arrows in insert mode issue

" Controversial...swap colon and semicolon for easier commands
"nnoremap ; :
"nnoremap : ;

"vnoremap ; :
"vnoremap : ;

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby setlocal foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
autocmd BufNewFile,BufRead *_spec.rb compiler rspec

" reload chromium on save certain files
" function! RefreshBrowser()
"   if &modified
"     write
"     silent !refresh-chromium
"   endif
" endfunction
" 
" autocmd BufWriteCmd *.html,*.css,*.haml,*.erb,*.sass,*.scss :call RefreshBrowser()

if &term=="screen"
  set term=xterm-256color
endif

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

" nmap <F2>:let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) - 1)', '')<CR> 
" nmap <F3>:let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) + 1)', '')<CR> 
colorscheme ir_black
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("pbpaste"))<CR>p
