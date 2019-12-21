set packpath=/usr/local/share/nvim/runtime,~/.local/share/nvim/site

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Tabs definition
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=0
set smarttab

