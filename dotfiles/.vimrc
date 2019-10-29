set nocompatible
set ttyfast
set re=1

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

" Set line length for tex files
autocmd BufNewFile,BufRead *.tex   set tw=80

" Enable filetype-specific plugins
filetype plugin on

" ========== CUSTOM SHORTCUTS ===
" Set <Space> to be leader
let mapleader = " "
let maplocalleader = ","

vnoremap <silent><leader>con y:let @"=system('base64 --decode', @")<cr>gvP

" Edit .vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
" Reload .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>:redraw!<cr>
" Open file in chrome
nnoremap <leader>c :exe ':silent !/usr/bin/open -a "/Applications/Google Chrome.app" %'<CR>

" execute current file
nnoremap <leader>ef :!%:p<cr>
" execute current buffer
nnoremap <leader>ex :%w !zsh<cr>

" copy path of current buffer
nnoremap <silent> <leader>cp :let @*=expand("%")<cr>
nnoremap <silent> <leader>cfp :let @*=expand("%:p")<cr>

" Remove byebug's
nnoremap <silent> <leader>rb :g/byebug/d<cr>

" Run linter faster
nnoremap <silent> <leader>l :ALEFix<cr>

" Format HTML file
nnoremap <silent> <leader>fh :!tidy -mib -html -wrap 0 %<cr>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Magic pattern matching
nnoremap / /\v
vnoremap / /\v

" ========== CTags ===
" Create the `tags` file, make sure that ctags is installed
command! MakeTags !ctags -f .tags -R .
" Lookup for tags file in current folder
set tags=.tags;/


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
set incsearch

" Ignore case while search
set ignorecase

" If search contains uppercase, takie case into account
set smartcase


" ========== PLUGINS ===
call plug#begin()

" GENERAL
Plug 'scrooloose/nerdtree'
map <leader>f :NERDTreeFind<CR>
let NERDTreeShowHidden=1

Plug 'vim-scripts/keepcase.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'henrik/vim-indexed-search'
Plug 'kana/vim-textobj-user'
Plug 'lucapette/vim-textobj-underscore'

Plug 'godlygeek/tabular'

" :Tab /=

" Plug 'junegunn/vim-easy-align' CRAPP

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

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'                   " Create shorcuts
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-endwise'
" Plug 'https://github.com/tpope/vim-abolish' " To learn
" Plug 'svermeulen/vim-easyclip'              " To check

Plug 'w0rp/ale'
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\   'vue': ['tslint'],
\   'javascript': ['eslint'],
\   'json': ['jq'],
\   'typescript': ['tslint'],
\   'scss': ['stylelint'],
\}
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_lint_on_text_changed    = 'never'

nmap <Leader>pe <Plug>(ale_previous_wrap)
nmap <Leader>ne <Plug>(ale_next_wrap)

" COLOR SCHEMA
Plug 'chriskempson/base16-vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }


" GIT
Plug 'mattn/webapi-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'mattn/gist-vim'
" set modifiable
Plug 'tpope/vim-rhubarb'


" CSS
Plug 'ap/vim-css-color'


" RUBY
Plug 'danchoi/ri.vim'
Plug 'rorymckinley/vim-rubyhash'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'AndrewRadev/splitjoin.vim'
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''

nmap <Leader>sj :SplitjoinSplit<cr>
nmap <Leader>js :SplitjoinJoin<cr>

Plug 'thoughtbot/vim-rspec'

" let g:rspec_command = ":Shell bundle exec rspec {spec}"
" let g:rspec_runner = "os_x_iterm2"

map <Leader>tf :call RunCurrentSpecFile()<CR>
map <Leader>ti :call RunNearestSpec()<CR>
map <Leader>tt :call RunLastSpec()<CR>

" Plug 'vim-ruby/vim-ruby'
let g:ruby_indent_block_style = 'do'
let ruby_operators = 1
let ruby_spellcheck_strings = 1

" Set filetype for file
function! s:setf(filetype) abort
  if &filetype !=# a:filetype
    let &filetype = a:filetype
  endif
endfunction

" Set Ruby filetypes for given files:
au BufNewFile,BufRead Guardfile,.Guardfile	call s:setf('ruby')
au BufNewFile,BufRead Capfile,*.cap		call s:setf('ruby')

" MARKDOWN
Plug 'JamshedVesuna/vim-markdown-preview'
let vim_markdown_preview_hotkey='<leader>m'
let vim_markdown_preview_github=0
let vim_markdown_preview_toggle=3
let vim_markdown_preview_browser='Google Chrome'


" SOLIDITY
Plug 'tomlion/vim-solidity'


Plug 'slim-template/vim-slim'
" JAVASCRIPT
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
Plug 'mxw/vim-jsx'
Plug 'hotoo/jsgf.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'leafOfTree/vim-vue-plugin'
" let g:vim_vue_plugin_load_full_syntax = 1
" let g:vim_vue_plugin_use_less = 1
let g:vim_vue_plugin_use_sass = 1
" let g:vim_vue_plugin_highlight_vue_attr = 1

" TYPESCRIPT
" Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0

" Plug 'ternjs/tern_for_vim'
" let g:tern_map_keys=1 " Enable keyboard shortcuts


" LATEX
Plug 'lervag/vimtex'
call plug#end()


" =========== INTERFACE ===
let base16colorspace=256
colorscheme base16-flat

" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Highlight cursor line
set cursorline
set nowrap

" Enable syntax highlighting
" syntax enable

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

" ========== CUSTOMIZE NETRW
" track current directory
let g:netrw_keepdir=1

" Tree style listing
let g:netrw_localrmdir='rm -r'
let g:netrw_liststyle=3

" ========== CUSTOM TEXT-OBJECTS

call textobj#user#plugin('subnames', {
\   'camel': {
\     'pattern': '[A-Z][A-Z0-9]*[a-z0-9]*',
\     'select': ['ac', 'ic']
\   },
\ })


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ======== CUSTOM SHELL RUNNER
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction

" Shortcuts

" Ctags and jumping


" ^]  = jump to tag
" g^] = show list if ambiguous match of tag
" ^t  = jump up

" ^]  - jump to tag
" g^] - show list if ambiguous match of tag
" ^t  - jump up

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
"
" Scroll
" CTRL-E / CTRL-Y - scroll down/up
"
" LateX
" <localleader>ll  - compile *.tex
"
" Merge two sets of lines
" :,+9g/^/''+10m.|-j!
