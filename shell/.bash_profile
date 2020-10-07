# Defulat programs
export VISUAL=nvim
export EDITOR="$VISUAL"
export BROWSER="firefox-developer-edition"
export READER="mupdf"

# Java application
export _JAVA_AWT_WM_NONREPARENTING=1 
export AWT_TOOLKIT=MToolkit

# Clean up path
export PATH=\
$HOME/.local/bin:\
$HOME/.yarn/bin:\
/usr/local/sbin:\
/usr/local/bin:\
/usr/sbin:\
/usr/bin:\
/sbin:\
/bin

# History management
export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTIGNORE="clear:cd:cd -:cd ..:exit:date:w:* --help:ls"

# Fzf settings
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f --follow'
export FZF_CTRL_T_COMMAND='fd --type f --follow'
export FZF_DEFAULT_OPTS='--height 20%'

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! ps -e | grep -qw Xorg && exec startx

#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

