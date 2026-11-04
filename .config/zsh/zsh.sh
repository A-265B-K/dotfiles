#!/usr/bin/env zsh
zmodload zsh/complist
autoload -Uz +X compinit && compinit
autoload -Uz +X colors && colors
autoload -Uz +X checkmail

# cmp
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' special-dirs true # . and .. in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colors in cmp
zstyle ':completion:*' squeeze-slashes false # allow /*/ expansion
zstyle ':completion:*:*:*:*:descriptions' format '%F{cyan} -- %d --%f' # nice formatting :3
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow} !-- %d --!%f' # nice formatting 2 :3
zstyle ':completion:*:*:*:*:messages' format '%F{blue} -- %d --%f' # nice formatting
zstyle ':completion:*:*:*:*:warnings' format '%F{red} -- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${HOME}/.cache/.zcompcache"
zstyle ':completion:*:*:-command-:*' group-order builtins functions commands


setopt auto_menu menu_complete # autocmp first match
setopt auto_param_slash # when dir completed, add / instead of trailing space
setopt list_packed # different linewidths for completion
setopt no_case_glob no_case_match # case insensitivity on cmp and globbing
setopt globdots # dotfiles included in globs
stty stop undef # wtf does ^s even do????

# history
setopt append_history # as opposed to overwriting
setopt inc_append_history # history appended immediately
setopt share_history # history shared
setopt hist_ignore_dups hist_ignore_space
HISTSIZE=1000000 # big milly
SAVEHIST=1000000
HISTFILE="${HOME}/.cache/zsh_history" # to cache you go!
HISTCONTROL=ignoreboth # repeat commands get ignored + ignore commands prefixed with space

# fzf
if which fzf 2>/dev/null >/dev/null; then
	source <(fzf --zsh) # fzf history widget
fi

# keeb

setopt vi

# bindkey "^a" beginning-of-line
# bindkey "^e" end-of-line
# bindkey "^H" backward-kill-word
# bindkey "^J" history-search-forward
# bindkey "^K" history-search-backward
# bindkey "^R" fzf-history-widget
