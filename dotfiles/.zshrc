# Path to your oh-my-zsh installation.
export ZSH="/Users/$USER/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"
export DEFAULT_USER=wojciechko

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
# <C-O> - Copy typed command
plugins=(git bundler copybuffer dotenv rails rake-fast z)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim=nvim

# Init rbenv
eval "$(rbenv init -)"

# Add some zsh fireworks
fpath=(/usr/local/share/zsh-completions $fpath)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Init nvm
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh" --no-use

# Init golang
export GOPATH=$HOME/dev/golang
export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:/Applications/MAMP/Library/bin

source $HOME/.cargo/env

# Init fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="$(brew --prefix qt@5.5)/bin:$PATH"

# Remove annoying gem
export RUBYOPT=--disable-did-you-mean

# Init base16 color scheme
BASE16_SHELL=$HOME/dotfiles/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# alias vim='mvim -v'

# change node version if enter to directory with .nvmrc file
# autoload -U add-zsh-hook
# load-nvmrc() {
#   local node_version="$(nvm version)"
#   local nvmrc_path="$(nvm_find_nvmrc)"

#   if [ -n "$nvmrc_path" ]; then
#     local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#     if [ "$nvmrc_node_version" = "N/A" ]; then
#       nvm install
#     elif [ "$nvmrc_node_version" != "$node_version" ]; then
#       nvm use
#     fi
#   elif [ "$node_version" != "$(nvm version default)" ]; then
#     echo "Reverting to nvm default version"
#     nvm use default
#   fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# Enable vim motions in terminal
# bindkey -v
# function zle-line-init zle-keymap-select {
#     VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
#     RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#     zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select
#
# source ~/dotfiles/opp.zsh/opp.zsh
# source ~/dotfiles/opp.zsh/opp/*.zsh
#

# Go to gem folder
function gtg() {
  cd "$(bundle show $1)"
}
unalias grv

function release() {
  kill -9 $(lsof -ti tcp:$1)
}
# Uninstall gems for for rbenv
# Credits:
# https://gist.github.com/IanVaughan/2902499#file-uninstall_gems-sh-L19
uninstall_current() {
  list=`gem list --no-versions`
  for gem in $list; do
    gem uninstall $gem -aIx
  done
  gem list
  gem install bundler
}

uninstall_for_all() {
  #rbenv versions --bare
  RBENVPATH=`rbenv root`
  echo $RBENVPATH
  RUBIES=`ls $RBENVPATH/versions`
  for ruby in $RUBIES; do
    echo '---------------------------------------'
    echo $ruby
    rbenv local $ruby
    uninstall_current
  done
}

# added by travis gem
[ -f /Users/wojciechko/.travis/travis.sh ] && source /Users/wojciechko/.travis/travis.sh
export PATH="/usr/local/opt/postgresql@10/bin:$PATH"

export LC_ALL=en_US.UTF-8
