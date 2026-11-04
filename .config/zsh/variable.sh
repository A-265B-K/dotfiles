#!/usr/bin/env zsh
# Ansi Color variables
ESC='\033['
COL_FORE=$ESC'38;2;'
COL_BACK=$ESC'48;2;'
COL_CLEAR=$ESC'0m'
NEWLINE=$'\n'
COL_ERR=$ESC'1;31m'
export BABEL_RM="yes"
export MAILCHECK=0

export EDITOR="nvim"
if which bat 2>/dev/null >/dev/null; then
	export PAGER='bat -l man -p --paging=always --strip-ansi always'
fi
export MANPAGER="$PAGER"
export NOTES_DIR="${HOME}/notes"
