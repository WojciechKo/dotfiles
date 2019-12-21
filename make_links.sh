BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${BASEDIR}/dotfiles"

# Create symlinks for dotfiles
# ln -fsv ${DOTFILES_DIR}/.zshrc ~
rm ~/.zshrc.pre-oh-my-zsh

ln -fsv ${DOTFILES_DIR}/.vimrc ~
ln -fsv ${DOTFILES_DIR}/.config/nvim/init.vim ~/.config/nvim/init.vim

ln -fsv ${DOTFILES_DIR}/.ctags ~

ln -fsv ${BASEDIR}/gitkurwa/config ~/.gitconfig_gitkurwa
ln -fsv ${DOTFILES_DIR}/.gitconfig ~
ln -fsv ${DOTFILES_DIR}/.gitignore ~
ln -fsv ${DOTFILES_DIR}/.gitconfig_local ~

# Install lambda-pure
mkdir ~/.zsh_functions
ln -fsv ${DOTFILES_DIR}/lambda-pure/lambda-pure.zsh ~/.zsh_functions/prompt_lambda-pure_setup
ln -fsv ${DOTFILES_DIR}/lambda-pure/async.zsh ~/.zsh_functions/async
