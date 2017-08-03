set nocompatible

" Create the `tags` file, make sure that ctags is installed
command! MakeTags !ctags -R .

" Lookup for tags file in current folder
set tags=tags;/

" Enable syntax highlighting
syntax enable

" Enable filetype-specific plugins
filetype plugin on

" Persistence and backup
silent !mkdir ~/.vim/.undo ~/.vim/.backup ~/.vim/.swp > /dev/null 2>&1
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" Display entered command
set showcmd

" Search all subfolders
set path +=**
" set wildmenu

" Highlight search results
set hlsearch

" new split is selected
set splitbelow
set splitright

" Set system clipboard as default
set clipboard=unnamed

" Redraw only if change
set lazyredraw

" Setup line number indicator
set number
set relativenumber

" Tabs definition
set tabstop=2
set shiftwidth=2
set expandtab

" Plug
call plug#begin()
Plug 'tpope/vim-sensible'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
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

Plug 'tpope/vim-surround'

Plug 'tpope/vim-repeat'

Plug 'Chiel92/vim-autoformat'

Plug 'w0rp/ale'
let g:ale_fixers = {
\ 'ruby': ['rubocop']
\}

let g:ale_fix_on_save = 1

Plug 'kchmck/vim-coffee-script'

call plug#end()
" Shortcuts

" Ctags and jumping
" ^] - jump to tag
" g^] - show list if ambiguous match of tag
" ^t - jump up
"
" Autocomplete
" ^n   - anything specified by the 'complete' option
" ^x^n - this file only
" ^x^f - filenames only
" ^x^] - tags only
