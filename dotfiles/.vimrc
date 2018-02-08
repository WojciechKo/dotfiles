set nocompatible

" Set system clipboard as default
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" Files with *.md extension are treat as markdown files
au BufNewFile,BufRead *.md set filetype=markdown

" Enable filetype-specific plugins
filetype plugin on

packadd! matchit

" ========== CUSTOM SHORTCUTS ===
" Set <Space> to be leader
let mapleader = " "

" Edit .vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
" Reload .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>:redraw!<cr>
" Open file in chrome
nnoremap <leader>c :exe ':silent !/usr/bin/open -a "/Applications/Google Chrome.app" %'<CR>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" ========== CTags ===
" Create the `tags` file, make sure that ctags is installed
command! MakeTags !ctags -f .tags -R .
" Lookup for tags file in current folder
set tags=.tags;/


" =========== INTERFACE ===
let base16colorspace=256
colorscheme base16-flat

" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Highlight cursor line
set cursorline
set nowrap

" Enable syntax highlighting
syntax enable

" Display entered command
set showcmd

" new split is selected
set splitbelow
set splitright

set diffopt=filler,vertical

" Setup line number indicator
set number
set relativenumber

" Redraw only if change
set lazyredraw

" Tabs definition
set tabstop=2
set shiftwidth=2
set expandtab


" ========== PERSISTENCE AND BACKUP ===
silent !mkdir ~/.vim/.undo ~/.vim/.backup ~/.vim/.swp > /dev/null 2>&1
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//


" ========== SEARCH ===
" Search in all subfolders
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


" ========== PLUGINS ===
call plug#begin()

" GENERAL
Plug 'scrooloose/nerdtree'
map <leader>f :NERDTreeFind<CR>

Plug 'bronson/vim-trailing-whitespace'
Plug 'lucapette/vim-textobj-underscore'
Plug 'godlygeek/tabular'

Plug 'mileszs/ack.vim'

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

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

Plug 'w0rp/ale'
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\}

nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)


" COLOR SCHEMA
Plug 'chriskempson/base16-vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }


" GIT
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
set modifiable
Plug 'tpope/vim-rhubarb'


" CSS
Plug 'ap/vim-css-color'


" RUBY
Plug 'rorymckinley/vim-rubyhash'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'AndrewRadev/splitjoin.vim'

Plug 'vim-ruby/vim-ruby'
let ruby_operators = 1
let ruby_spellcheck_strings = 1
let g:ruby_indent_block_style = 'do'


" MARKDOWN
Plug 'JamshedVesuna/vim-markdown-preview'
let vim_markdown_preview_toggle=0
let vim_markdown_preview_hotkey='<leader>m'
let vim_markdown_preview_browser='Google Chrome'
" let vim_markdown_preview_github=1


" SOLIDITY
Plug 'tomlion/vim-solidity'


" JAVASCRIPT
Plug 'moll/vim-node'
Plug 'kchmck/vim-coffee-script'

Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0

Plug 'ternjs/tern_for_vim'
let g:tern_map_keys=1 " Enable keyboard shortcuts


" LATEX
Plug 'lervag/vimtex'
call plug#end()

" ========== CUSTOMIZE NETRW
" track current directory
let g:netrw_keepdir=1

" Tree style listing
let g:netrw_localrmdir='rm -r'
let g:netrw_liststyle=3

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


" FOLDS
" zj - go to previous fold
" zk - go to next fold
" za - toggle fold
