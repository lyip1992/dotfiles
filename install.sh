#!/usr/bin/env bash

# Check If Dependencies Are Installed
which fc-cache >/dev/null || { # check if fc-cache is in our path
  echo "fc-cache not found in path..."
  exit 1
}

which git >/dev/null || { # check if git is in our path
  echo "git not found in path..."
  exit 1
}

# Install Tmux Plugins
echo "Installing tmux plugins..."
git submodule init
git submodule update
git submodule update --init --recursive

# Get Current Directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create Symlinks
echo "Creating symlinks..."
ln -sfv "$DOTFILES_DIR/.bash_profile" ~/.bash_profile
ln -sfv "$DOTFILES_DIR/.vimrc" ~/.vimrc
ln -sfv "$DOTFILES_DIR/.ideavimrc" ~/.ideavimrc
ln -sfv "$DOTFILES_DIR/.vim/" ~/.vim
ln -sfv "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
ln -sfv "$DOTFILES_DIR/.fonts/" ~/.fonts
ln -sfv "$DOTFILES_DIR/.tmux/" ~/.tmux
ln -sfv "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
ln -sfv "$DOTFILES_DIR/.inputrc" ~/.inputrc
ln -sfv "$DOTFILES_DIR/.gitignore_global" ~/.gitignore_global

# Update Font Cache
fc-cache -vrf ~/.fonts

# Init Bash Profile
source ~/.bash_profile
