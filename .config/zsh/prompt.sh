#!/usr/bin/env zsh
COL_GOB_FORE=$COL_FORE'51;161;62m' #R;G;Bm
COL_GOB_BACK=$COL_BACK'77;34;110m' #R;G;Bm
COL_GOB='%{'$COL_GOB_FORE$COL_GOB_BACK'%}'
COL_TERM_FORE=$COL_FORE'181;186;80m'
COL_TERM_BACK=$COL_BACK'91;80;186m'
COL_TERM='%{'$COL_TERM_FORE$COL_TERM_BACK'%}'
COL_PWD_FORE=$COL_FORE'19;100;186m' #R;G;Bm
COL_PWD_BACK=$COL_BACK'240;139;46m' #R;G;Bm
COL_PWD='%{'$COL_PWD_FORE$COL_PWD_BACK'%}'
GOB_PROMPT=$(echo $COL_GOB'goblin-%m''%{'$COL_CLEAR'%}') #%m => hostname
GOB_TERM=$(echo $COL_TERM'\t%l''%{'$COL_CLEAR'%}')
PWD_PROMPT=$(echo $COL_PWD'\t%~''%{'$COL_CLEAR'%}') #%~ => PWD
PWD_ERR=$(echo '%{'$COL_ERR'%}''%? ''%{'$COL_CLEAR'%}')
autoload -Uz add-zsh-hook vcs_info
zstyle ':vcs_info:git:*' formats ' (%b)'
add-zsh-hook precmd vcs_info
update_nix_prompt() {
	if [[ -n $IN_NIX_SHELL ]]; then
		NIX_PROMPT=$COL_TERM_FORE$COL_TERM_BACK'nix:'$IN_NIX_SHELL$COL_CLEAR
	else
		NIX_PROMPT=''
	fi
}
add-zsh-hook precmd update_nix_prompt
setopt prompt_subst
PS1=$GOB_PROMPT$GOB_TERM'%{${NIX_PROMPT}%}'$PWD_PROMPT'${vcs_info_msg_0_}'$NEWLINE"%(?..$PWD_ERR)%# " #PS1 is weird and doesnt like newlines
