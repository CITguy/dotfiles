:helptags ~/.vim/doc " include docs in home directory

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

call pathogen#infect()

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

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showmode   " shows mode on last line of vim buffer
set showcmd    " display incomplete commands
set incsearch  " do incremental searching

set t_Co=256    " use 256 color in terminal
syntax on       " turn on syntax highlighting
set hlsearch    " highlight the last used search pattern

" only one of the following can be turned on at a time
set number         " Show the line number for each line
set relativenumber " show relative line number to current line (pretty cool, might get confusing)

set ts=2        " Set Tab stop width (2 spaces per tab)
set sw=2        " Set shift width (2 spaces)
set so=4        " Set scrolloff (number of lines to show around the cursor)
set siso=4      " Set side scrolloff, similar to scrolloff but horizontal
set ch=1        " Set cmdheight lines
set laststatus=2
set noautoindent smartindent
set expandtab
set nowrap      " don't wrap lines
set nolinebreak " linebreak: not used if 'wrap' is off
set title
set mh          " hide the mouse when typing text
set mouse-=     " disable mouse usage
set wildmenu
set cul         " Show Cursor Line
set nocuc       " Do NOT Show Cursor Column
set mm=10240    " 10MB limit (per file) memory usage
set mmt=2000000 " No limit on total memory usage
"set ssop=folds,help,tabpages,unix
"set shm=aToO   " Shortmess info, see :shortmess
set autoread    " automatically read file if it has changed outside of Vim
set equalalways " equals window sizes on add/remove of new window
set noexrc      " do not automatically load .vimrc, .exrc and .gvimrc in current directory
set ttyfast     " (use locally) indicates a fast terminal connection

set listchars=tab:..,eol:$
set nolist      " display listchars


" This is to limit the syntax-highlighting to the first 120 columns
" Useful for files with very long lines
"set synmaxcol=120

" Seems to help when trying to edit file with deep folds
set lazyredraw


" folding settings
set foldmethod=indent " fold based on indent
set foldcolumn=0      " No foldcolumn
set foldnestmax=30    " deepest fold is 10 levels
set foldlevel=10      " keep ALL folds open on file open (must be GTE than foldnestmax)
set foldenable        " Enable Folding


" ===========================================================
" MAPPINGS
" ===========================================================
let mapleader=","

" mapping CTRL+Arrow to switch between split windows
map <C-Down> <C-W><Down>
map <C-Up> <C-W><Up>
map <C-Left> <C-W><Left>
map <C-Right> <C-W><Right>

nmap <Leader>n :NERDTreeToggle<CR>
" Don't use Ex mode, use Q for formatting
map Q gq
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
" Disable Highlighting
noremap <C-K> :nohls<CR>

" Dark Theme
colorscheme tir_black
" Light Themes
"colorscheme mayansmoke
"colorscheme summerfruit256

" This is so snipMate works
":filetype plugin on

" fileformat, encoding, type, buffer num, RO/HELP/PREVIEW, mod flag, filepath; spacer; line pos, line/total, percentage
set statusline=%{&ff}\ \%{&fenc}\ \b%1.3n\ \%#StatusFTP#\%Y\ \%#StatusRO#\%R\ \%#StatusHLP#\%H\ \%#StatusPRV#\%W\ \%#StatusModFlag#\%M\ \%#StatusLine#\%f\%=\%1.7c\ \%1.7l/%L\ \%p%%


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

"" Only highlight a single char at column 81
"highlight ColorColumn ctermbg=DarkRed
"call matchadd('ColorColumn', '\%81v', 100)

" set tabstop and shiftwidth to 4 ONLY for python files
au Filetype python setl et ts=4 sw=4

let g:github_api_url = 'http://github.rackspace.com/api/v3'

" https://coderwall.com/p/faceag
function! ReformatJSON()
  %!python -m json.tool
endfunction
