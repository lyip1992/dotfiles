#!/usr/bin/env bash

which git >/dev/null || { # check if git is in our path
  echo "git not found in path..."
  exit 1
}

TMUX_PLUGINS_DIR="${HOME}/.tmux/plugins" # cache plugins directory

if [[ -d "${TMUX_PLUGINS_DIR}" ]]; then # update plugins if directory is present
  echo "Updating tmux plugins..."
  git submodule foreach git pull --rebase origin master
  git submodule foreach git submodule update --init --recursive
fi
