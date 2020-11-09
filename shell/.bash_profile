# Defulat programs
export VISUAL=nvim
export EDITOR="$VISUAL"
export BROWSER="firefox-developer-edition"
export READER="mupdf"

# History management
export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTIGNORE="clear:cd:cd -:cd ..:exit:date:w:* --help:ls"

# Java application
export JAVA_HOME="/usr/lib/jvm/default"
export JRE_HOME="/usr/lib/jvm/default/jre"
export ANDROID_HOME="$HOME/Android/Sdk"
export _JAVA_AWT_WM_NONREPARENTING=1 
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export JAVA_FONTS=/usr/share/fonts/TTF
export AWT_TOOLKIT=MToolkit

# FZF settings
export FZF_DEFAULT_COMMAND="fd --type f --follow"
export FZF_CTRL_T_COMMAND="fd --type f --follow"
export FZF_DEFAULT_OPTS="--height 20%"

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

# Clean up path
export PATH=\
$HOME/.yarn/bin:\
$JAVA_HOME/bin:\
$ANDROID_HOME/platform-tools:\
$ANDROID_HOME/emulator:\
$ANDROID_HOME/tools:\
$HOME/.local/bin:\
/usr/local/sbin:\
/usr/local/bin:\
/usr/sbin:\
/usr/bin:\
/sbin:\
/bin

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! ps -e | grep -qw Xorg && exec startx

#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc



