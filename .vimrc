" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

call pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showmode
set showcmd     " display incomplete commands
set incsearch   " do incremental searching

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

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

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


" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

set t_Co=256 " use 256 color in terminal
:helptags ~/.vim/doc " include docs in home directory

set relativenumber " show relative line number to current line
set ts=2 " Set Tab stop width (2 spaces per tab)
set sw=2 " Set shift width (2 spaces)
set so=4 " Set scrolloff (number of lines to show around the cursor)
set siso=4  " Set side scrolloff, similar to scrolloff but horizontal
set ch=1 " Set cmdheight lines
set laststatus=2
set noautoindent smartindent
set expandtab
set nowrap " don't wrap lines
set title
set mh " hide the mouse when typing text
set mouse-=a " disable visual selection mode for mouse"
set wildmenu
set cul " Show Cursor Line
set nocuc " Do NOT Show Cursor Column
set mm=10240 " 10MB limit (per file) memory usage
set mmt=2000000 " No limit on total memory usage
"set ssop=folds,help,tabpages,unix
"set shm=aToO " Shortmess info, see :shortmess
set nolist
set listchars=tab:..,eol:$
set autoread " automatically read file if it has changed outside of Vim

set equalalways " equals window sizes on add/remove of new window
set noexrc " do not automatically load .vimrc, .exrc and .gvimrc in current directory
set nolinebreak

set ttyfast " (use locally) indicates a fast terminal connection

" This is to limit the syntax-highlighting to the first 120 columns
" Useful for files with very long lines
"set synmaxcol=120

" Seems to help when trying to edit file with deep folds
set lazyredraw

set noerrorbells
set visualbell
set wildignore=*.swp,*.bak,*.pyc,*.class


" folding settings
set foldmethod=indent " fold based on indent
set foldcolumn=0 " No foldcolumn
set foldnestmax=10 " deepest fold is 10 levels
set foldlevel=10 " keep ALL folds open on file open (must be GTE than foldnestmax)
set foldenable " Enable Folding


" ===========================================================
" MAPPINGS
" ===========================================================
let mapleader=","

" mapping CTRL+Arrow to switch between split windows
map <C-H> <C-W><Left>
map <C-J> <C-W><Down>
map <C-K> <C-W><Up>
map <C-L> <C-W><Right>

nmap <Leader>n :NERDTreeToggle<CR>
" Don't use Ex mode, use Q for formatting
map Q gq
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
" Disable Highlighting
noremap <C-\> :nohls<CR>


colorscheme tir_black
"colorscheme darkcourses-stdl

" This is so snipMate works
":filetype plugin on

" Dark Yellow for columns 81-100
"highlight OverLengthWarn ctermfg=DarkYellow guibg=#595959
"match OverLengthWarn /\%>80v\%<101v/

" Dark Red for columns 101+
"highlight OverLengthDanger ctermfg=DarkRed guibg=#592929
"2match OverLengthDanger /\%>100v.\+/

" fileformat, encording, ('b' + buffer num), RO, PREVIEW, mod flag, filepath, spacer, col, line/total lines, pct
set statusline=%{&ff}\ %{&fenc}\ \b%1.3n\ %Y\ %r\ %W\ %m\ %F%=\ %1.7c\ %1.7l/%L\ %p%%

" vim-ruby-xmpfilter key mapping
" Gvim
nmap <buffer> <M-r> <Plug>(xmpfilter-run)
xmap <buffer> <M-r> <Plug>(xmpfilter-run)
imap <buffer> <M-r> <Plug>(xmpfilter-run)

nmap <buffer> <M-m> <Plug>(xmpfilter-mark)
xmap <buffer> <M-m> <Plug>(xmpfilter-mark)
imap <buffer> <M-m> <Plug>(xmpfilter-mark)

" Terminal
nmap <buffer> <F5> <Plug>(xmpfilter-run)
xmap <buffer> <F5> <Plug>(xmpfilter-run)
imap <buffer> <F5> <Plug>(xmpfilter-run)

nmap <buffer> <F4> <Plug>(xmpfilter-mark)
xmap <buffer> <F4> <Plug>(xmpfilter-mark)
imap <buffer> <F4> <Plug>(xmpfilter-mark)
