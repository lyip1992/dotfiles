# dotfiles

This repository contains all of my dotfiles along with setup instructions

## Setting Up Symlinks and Vim On Another Machine

Please make sure you install and use the font from the `.font/` folder before proceeding

    git clone git@git.musta.ch:leon-yip/dotfiles.git ~/dotfiles
    cd dotfiles
    ./install.sh

## Install/Update Plugins and Update Plugged

Execute in vim

    :PlugInstall
    :PlugUpdate
    :PlugUpgrade

## Adding Plugins

In `.vimrc`

    call plug#begin('~/.vim/plugged')
    ...

    Plug 'tpope/vim-fugitive'
    ...
    call plug#end()
