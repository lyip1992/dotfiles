# Init Shell Theme
source $HOME/dotfiles/.vim/pack/plugins/start/themes/shell/base16-oceanicnext.dark.sh

# Init fzf
[ -f $HOME/dotfiles/.fzf.bash ] && source $HOME/dotfiles/.fzf.bash

HISTCONTROL=ignoreboth

# Git
alias gs='git status'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstd='git stash drop'
alias ga='git add'
alias gd='git difftool'
alias gmt='git mergetool'
alias gci='git commit'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gpocb='gpo `git symbolic-ref --short HEAD`'
alias gp='git pull'
alias gpum='git pull upstream master'
alias gprum='git pull --rebase upstream master'
alias gprom='git pull --rebase origin master'
alias gr='git remote'
alias grau='git remote add upstream'
alias gh='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
alias gb='git branch'
alias gbD='git branch -D'
alias gco='git checkout'
alias gc='git clone'

# Hub
alias hb='hub browse'
alias hpr='hub pull-request'

# Brew
alias bd='brew doctor'
alias bucp='brew update && brew upgrade && brew cleanup && brew prune'
alias bu='brew update && brew upgrade'
alias bc='brew cleanup'
alias bp='brew prune'
alias bl='brew list'

# Meta
alias ls='ls -Gp'
alias lsa='ls -Gpa'
alias ll='ls -Gpl'
alias cl='clear'
alias prof='vim ~/.bash_profile'
alias reprof='. ~/.bash_profile'

# Navigation
ds () {
  cd ~/Documents
}
de () {
  cd ~/Desktop
}
dl () {
  cd ~/Downloads
}
icloud () {
  cd ~/iCloud
}

# Combine mkdir and cd
mkcd () {
  mkdir "$1"
  cd "$1"
}

# NPM
alias npmi="npm install"
alias npmig="npm i -g npm"
alias npms="npm start"

# New File
toa () {
  touch "$1"
  atom "$1"
}

# GNU Grep
alias ggrep='ggrep --color -in'

# Simple Server
alias serve='python -m SimpleHTTPServer'

# Postgresql
alias pgconnect='postgres -D /usr/local/var/postgres'

psconnect () {
  psql -d "$1"
}

# Path
export PATH="/usr/local/sbin:$PATH"

# Environment Variables
export JAVA_HOME=$(/usr/libexec/java_home)
export GIT_EDITOR=$(which vim)
export VISUAL=`which vim`
export GITHUB_HOST=git.musta.ch
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_COMPLETION_TRIGGER='~~'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Bash Completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Mosh Completion
complete -F _fzf_complete_ssh -o default -o bashdefault mosh

# AWS Completion
complete -C aws_completer aws

# Utility
alias bt="wget http://cachefly.cachefly.net/100mb.test -O /dev/null"

# Promptline
function __promptline_host {
  local only_if_ssh="0"

  if [ ! $only_if_ssh -o -n "${SSH_CLIENT}" ]; then
    if [[ -n ${ZSH_VERSION-} ]]; then print %m; elif [[ -n ${FISH_VERSION-} ]]; then hostname -s; else printf "%s" \\h; fi
  fi
}

function __promptline_last_exit_code {

  [[ $last_exit_code -gt 0 ]] || return 1;

  printf "%s" "$last_exit_code"
}
function __promptline_ps1 {
  local slice_prefix slice_empty_prefix slice_joiner slice_suffix is_prompt_empty=1

  # section "a" header
  slice_prefix="${a_bg}${sep}${a_fg}${a_bg}${space}" slice_suffix="$space${a_sep_fg}" slice_joiner="${a_fg}${a_bg}${alt_sep}${space}" slice_empty_prefix="${a_fg}${a_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "a" slices
  __promptline_wrapper "$(__promptline_host)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # section "b" header
  slice_prefix="${b_bg}${sep}${b_fg}${b_bg}${space}" slice_suffix="$space${b_sep_fg}" slice_joiner="${b_fg}${b_bg}${alt_sep}${space}" slice_empty_prefix="${b_fg}${b_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "b" slices
  __promptline_wrapper "$USER" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # section "c" header
  slice_prefix="${c_bg}${sep}${c_fg}${c_bg}${space}" slice_suffix="$space${c_sep_fg}" slice_joiner="${c_fg}${c_bg}${alt_sep}${space}" slice_empty_prefix="${c_fg}${c_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "c" slices
  __promptline_wrapper "$(__promptline_cwd)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # section "y" header
  slice_prefix="${y_bg}${sep}${y_fg}${y_bg}${space}" slice_suffix="$space${y_sep_fg}" slice_joiner="${y_fg}${y_bg}${alt_sep}${space}" slice_empty_prefix="${y_fg}${y_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "y" slices
  __promptline_wrapper "$(__promptline_vcs_branch)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # section "warn" header
  slice_prefix="${warn_bg}${sep}${warn_fg}${warn_bg}${space}" slice_suffix="$space${warn_sep_fg}" slice_joiner="${warn_fg}${warn_bg}${alt_sep}${space}" slice_empty_prefix="${warn_fg}${warn_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "warn" slices
  __promptline_wrapper "$(__promptline_last_exit_code)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # close sections
  printf "%s" "${reset_bg}${sep}$reset$space"
}
function __promptline_vcs_branch {
  local branch
  local branch_symbol=" "

  # git
  if hash git 2>/dev/null; then
    if branch=$( { git symbolic-ref --quiet HEAD || git rev-parse --short HEAD; } 2>/dev/null ); then
      branch=${branch##*/}
      printf "%s" "${branch_symbol}${branch:-unknown}"
      return
    fi
  fi
  return 1
}
function __promptline_cwd {
  local dir_limit="3"
  local truncation="⋯"
  local first_char
  local part_count=0
  local formatted_cwd=""
  local dir_sep="  "
  local tilde="~"

  local cwd="${PWD/#$HOME/$tilde}"

  # get first char of the path, i.e. tilde or slash
  [[ -n ${ZSH_VERSION-} ]] && first_char=$cwd[1,1] || first_char=${cwd::1}

  # remove leading tilde
  cwd="${cwd#\~}"

  while [[ "$cwd" == */* && "$cwd" != "/" ]]; do
    # pop off last part of cwd
    local part="${cwd##*/}"
    cwd="${cwd%/*}"

    formatted_cwd="$dir_sep$part$formatted_cwd"
    part_count=$((part_count+1))

    [[ $part_count -eq $dir_limit ]] && first_char="$truncation" && break
  done

  printf "%s" "$first_char$formatted_cwd"
}
function __promptline_left_prompt {
  local slice_prefix slice_empty_prefix slice_joiner slice_suffix is_prompt_empty=1

  # section "a" header
  slice_prefix="${a_bg}${sep}${a_fg}${a_bg}${space}" slice_suffix="$space${a_sep_fg}" slice_joiner="${a_fg}${a_bg}${alt_sep}${space}" slice_empty_prefix="${a_fg}${a_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "a" slices
  __promptline_wrapper "$(__promptline_host)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # section "b" header
  slice_prefix="${b_bg}${sep}${b_fg}${b_bg}${space}" slice_suffix="$space${b_sep_fg}" slice_joiner="${b_fg}${b_bg}${alt_sep}${space}" slice_empty_prefix="${b_fg}${b_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "b" slices
  __promptline_wrapper "$USER" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # section "c" header
  slice_prefix="${c_bg}${sep}${c_fg}${c_bg}${space}" slice_suffix="$space${c_sep_fg}" slice_joiner="${c_fg}${c_bg}${alt_sep}${space}" slice_empty_prefix="${c_fg}${c_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "c" slices
  __promptline_wrapper "$(__promptline_cwd)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # close sections
  printf "%s" "${reset_bg}${sep}$reset$space"
}
function __promptline_wrapper {
  # wrap the text in $1 with $2 and $3, only if $1 is not empty
  # $2 and $3 typically contain non-content-text, like color escape codes and separators

  [[ -n "$1" ]] || return 1
  printf "%s" "${2}${1}${3}"
}
function __promptline_right_prompt {
  local slice_prefix slice_empty_prefix slice_joiner slice_suffix

  # section "warn" header
  slice_prefix="${warn_sep_fg}${rsep}${warn_fg}${warn_bg}${space}" slice_suffix="$space${warn_sep_fg}" slice_joiner="${warn_fg}${warn_bg}${alt_rsep}${space}" slice_empty_prefix=""
  # section "warn" slices
  __promptline_wrapper "$(__promptline_last_exit_code)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; }

  # section "y" header
  slice_prefix="${y_sep_fg}${rsep}${y_fg}${y_bg}${space}" slice_suffix="$space${y_sep_fg}" slice_joiner="${y_fg}${y_bg}${alt_rsep}${space}" slice_empty_prefix=""
  # section "y" slices
  __promptline_wrapper "$(__promptline_vcs_branch)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; }

  # close sections
  printf "%s" "$reset"
}
function __promptline {
  local last_exit_code="${PROMPTLINE_LAST_EXIT_CODE:-$?}"

  local esc=$'[' end_esc=m
  if [[ -n ${ZSH_VERSION-} ]]; then
    local noprint='%{' end_noprint='%}'
  elif [[ -n ${FISH_VERSION-} ]]; then
    local noprint='' end_noprint=''
  else
    local noprint='\[' end_noprint='\]'
  fi
  local wrap="$noprint$esc" end_wrap="$end_esc$end_noprint"
  local space=" "
  local sep=""
  local rsep=""
  local alt_sep=""
  local alt_rsep=""
  local reset="${wrap}0${end_wrap}"
  local reset_bg="${wrap}49${end_wrap}"
  local a_fg="${wrap}38;5;18${end_wrap}"
  local a_bg="${wrap}48;5;2${end_wrap}"
  local a_sep_fg="${wrap}38;5;2${end_wrap}"
  local b_fg="${wrap}38;5;21${end_wrap}"
  local b_bg="${wrap}48;5;19${end_wrap}"
  local b_sep_fg="${wrap}38;5;19${end_wrap}"
  local c_fg="${wrap}38;5;16${end_wrap}"
  local c_bg="${wrap}48;5;18${end_wrap}"
  local c_sep_fg="${wrap}38;5;18${end_wrap}"
  local warn_fg="${wrap}38;5;232${end_wrap}"
  local warn_bg="${wrap}48;5;166${end_wrap}"
  local warn_sep_fg="${wrap}38;5;166${end_wrap}"
  local y_fg="${wrap}38;5;21${end_wrap}"
  local y_bg="${wrap}48;5;19${end_wrap}"
  local y_sep_fg="${wrap}38;5;19${end_wrap}"
  if [[ -n ${ZSH_VERSION-} ]]; then
    PROMPT="$(__promptline_left_prompt)"
    RPROMPT="$(__promptline_right_prompt)"
  elif [[ -n ${FISH_VERSION-} ]]; then
    if [[ -n "$1" ]]; then
      [[ "$1" = "left" ]] && __promptline_left_prompt || __promptline_right_prompt
    else
      __promptline_ps1
    fi
  else
    PS1="$(__promptline_ps1)"
  fi
}

if [[ -n ${ZSH_VERSION-} ]]; then
  if [[ ! ${precmd_functions[(r)__promptline]} == __promptline ]]; then
    precmd_functions+=(__promptline)
  fi
elif [[ -n ${FISH_VERSION-} ]]; then
  __promptline "$1"
else
  if [[ ! "$PROMPT_COMMAND" == *__promptline* ]]; then
    PROMPT_COMMAND='__promptline;'$'\n'"$PROMPT_COMMAND"
  fi
fi
