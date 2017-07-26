" An example for a vimrc file.
"
" Maintainer: Bram Moolenaar <Bram@vim.org>
" Last change:  2016 Jul 28
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"       for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"     for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup    " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile  " keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif

" Plug
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'Chiel92/vim-autoformat'
Plug 'w0rp/ale'
Plug 'kchmck/vim-coffee-script'
call plug#end()

execute pathogen#infect()

" new split is selected
set splitbelow
set splitright

" Some fancy shortcut
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" FZF mapping
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g>g :Ag<CR>
nnoremap <leader><leader> :Commands<CR>
nnoremap <C-p> :call FzfOmniFiles()<CR>

fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun

" Autoformat
let g:ale_fixers = {
\ 'ruby': ['rubocop']
\}

let g:ale_fix_on_save = 1

" Setup line number indicator
set number
set relativenumber

set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Tabs definition
set tabstop=2
set shiftwidth=2
set expandtab

" Persistence
set noswapfile
set nobackup
set nowb

if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif
