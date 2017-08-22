set nocompatible

" ### CTags
"
" Create the `tags` file, make sure that ctags is installed
command! MakeTags !ctags -f .tags -R .
" Lookup for tags file in current folder
set tags=.tags;/

" Set <Space> to be leader
let mapleader = " "

" Files with *.md extension treat as markdown files
au BufNewFile,BufRead *.md set filetype=markdown
" Edit .vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
" Reload .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>:redraw!<cr>

" Open file in chrome
nnoremap <leader>c :exe ':silent !/usr/bin/open -a "/Applications/Google Chrome.app" %'<CR>

" Highlight cursor line
set cursorline

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

" Setup wildmenu
set wildmenu
set wildmode=longest:full,full

" Highlight search results
set hlsearch

" Ignore case while search
set ignorecase

" If search contains uppercase, takie case into account
set smartcase

" new split is selected
set splitbelow
set splitright

set diffopt=filler,vertical

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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

" track current directory
let g:netrw_keepdir=1

" Tree style listing
let g:netrw_localrmdir='rm -r'
let g:netrw_liststyle=3

" Plug
call plug#begin()
Plug 'airblade/vim-gitgutter'

Plug 'altercation/vim-colors-solarized'

Plug 'ap/vim-css-color'

Plug 'bronson/vim-trailing-whitespace'

Plug 'godlygeek/tabular'

Plug 'JamshedVesuna/vim-markdown-preview'
let vim_markdown_preview_toggle=0
let vim_markdown_preview_hotkey='<leader>m'
let vim_markdown_preview_browser='Google Chrome'
" let vim_markdown_preview_github=1

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g>g :Ag<CR>
nnoremap <leader><leader> :Commands<CR>
nnoremap <C-p> :Files<CR>

" fun! FzfOmniFiles()
"   let is_git = system('git status')
"   if v:shell_error
"     :Files
"   else
"     :GitFiles
"   endif
" endfun

Plug 'moll/vim-node'
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0
Plug 'ternjs/tern_for_vim'
" Enable keyboard shortcuts
let g:tern_map_keys=1

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-fugitive'
autocmd BufReadPost fugitive://* set bufhidden=delete

" Allows to update index with save to index file
set modifiable

Plug 'tpope/vim-sensible'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-repeat'

Plug 'tpope/vim-unimpaired'

Plug 'w0rp/ale'

Plug 'vim-ruby/vim-ruby'
let ruby_operators = 1
let ruby_spellcheck_strings = 1
let g:ruby_indent_block_style = 'do'

Plug 'kchmck/vim-coffee-script'

Plug 'scrooloose/nerdtree'
map <leader>f :NERDTreeFind<CR>

call plug#end()

let g:solarized_termcolors=256
colorscheme solarized
" Shortcuts

" Ctags and jumping
" ^]                 - jump to tag
" g^]                - show list if ambiguous match of tag
" ^t                 - jump up

" Autocomplete
" ^n                 - anything specified by the 'complete' option
" ^x^n               - this file only
" ^x^f               - filenames only
" ^x^]               - tags only

" Netrw
" gn                 - set top directory
