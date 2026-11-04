#!/usr/bin/env zsh
# Useful aliases
alias ccf='cc -Wall -Wextra -Werror'
alias ls='ls -aF --group-directories-first --color=auto'
alias cls='clear && ls'
alias ..='cd ..'
alias rm='rm -vd'

# git aliases
alias coomit='git commit -m'
alias push='git push'
alias add='git add'
alias pull='git pull'

alias gs='git status'
alias cinit='"$HOME/dotfiles/install.sh" --pull'
alias vim='nvim'
alias lg='lazygit'
alias ldo='lazydocker'
alias grep='grep --color=always'
