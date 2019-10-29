set packpath=/usr/local/share/nvim/runtime,~/.local/share/nvim/site

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set expandtab
