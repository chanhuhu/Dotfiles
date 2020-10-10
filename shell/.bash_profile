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
export FZF_DEFAULT_COMMAND='fd --type f --follow'
export FZF_CTRL_T_COMMAND='fd --type f --follow'
export FZF_DEFAULT_OPTS='--height 20%'

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



