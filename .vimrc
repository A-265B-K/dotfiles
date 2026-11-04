" Ensure vim is using vim settings
if &compatible
 set nocompatible
endif
silent! while 0
 set nocompatible
silent! endwhile

" i love colors
if &t_Co > 2 || has("gui_running")
 syntax on
 let c_comment_strings=1
endif

set nu rnu				" Activate both numbering and relative numbering
set backspace=indent,eol,start		" Allow backspacing over everything in insert mode
set history=200				" Keep 200 lines of cl history
set ruler				" Always show cursor pos
set showcmd				" Show incomplete commands
set wildmenu				" Show completion matches in a status line
set display=truncate			" Show @@@ if last line is truncated
set autoindent				" Auto indentation
set ts=4				" Tabwidth = 4 spaces
set path+=**
command! MakeTags !ctags -R .

