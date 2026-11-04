#!/usr/bin/env zsh

warn() {
	echo "[WARN]: $@" >&2
}

_sourceExisting() {
	if [ -e "$1" ]; then
		. "$1" || warn "failed to source $1"
	elif [ "$2" = "warn" ]; then
		echo "[WARN]: $1 doesnt exist" >&2
	fi
}

_sourceExisting "${HOME}/.path.sh"
_sourceExisting "${HOME}/.cargo/env"
_sourceExisting "${HOME}/.config/zsh/zsh.sh" warn
_sourceExisting "${HOME}/.config/zsh/variable.sh" warn
_sourceExisting "${HOME}/.config/zsh/aliase.sh" warn
_sourceExisting "${HOME}/.config/zsh/prompt.sh" warn
