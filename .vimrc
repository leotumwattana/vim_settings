" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

silent! call pathogen#runtime_append_all_bundles()

syntax enable			    " Turn on syntax highlighting.
filetype plugin indent on	    " Turn on file type detection.

runtime macros/matchit.vim	    " Load the matchit plugin.

" allow backspacing over everything in insert mode

set showcmd                         " display incomplete commands
set showmode                        " Display the mode you're in.

set backspace=indent,eol,start      " Intuitive backspacing.

set history=100                     " keep 50 lines of command line history
set hidden                          " better handling of multiple files

set wildmenu                        " Enhanced command line completion.
set wildmode=list:longest           " Complete files like a shell.

set ignorecase			    " Case-insensitive searching.
set smartcase			    " But case-sensitive if expression contains a capital letter.

set number                          " show line numbers
set ruler                           " show the cursor position all the time

set incsearch                       " do incremental searching
set hlsearch                        " set highlight search

set wrap                            " Turn on line wrapping
set scrolloff=3                     " Show 3 lines of context around the cursor.

set foldenable                      " Enable code folding

set title                           " Set the terminal's title

set visualbell                      " No beeping.
set guifont=Menlo:h16               " set MacVIM font

"set list                            " show invisible characters
let mapleader=";"                   " Change <leader> to ;

set softtabstop=2                   " set soft tabs to 2
set shiftwidth=2                    " And again, related
set expandtab                       " Use spaces instead of tabs

set nobackup                        " Don't make a backup before overwriting a file.
set nowritebackup                   " And again.
set noswapfile                      "no swap files
"set directory=$HOME/.vim/tmp//,.    " Keep swap files in one location

set splitbelow                      " Split windows BELOW current window.

set shell=/bin/bash

" Use color theme
colorscheme railscasts

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

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
autocmd BufNewFile,BufRead *_spec.rb compiler rspec
