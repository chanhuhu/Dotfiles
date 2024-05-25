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
export CHROME_EXECUTABLE=/usr/sbin/google-chrome-stable

# Go dir
export GOPATH="$HOME/.local/go"
export GOBIN="$GOPATH/bin"

# FZF settings
export FZF_DEFAULT_COMMAND="fd --type f --follow"
export FZF_CTRL_T_COMMAND="fd --type f --follow"
export FZF_DEFAULT_OPTS="--height 50%"

export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

# Less Colors for Man Pages
man() {
    # mb = begin blinking
    # md = begin bold
    # me = end mode
    # se = end standout-mode
    # so = begin standout-mode - info box
    # ue = end underline
    # us = begin underline
    env \
    LESS="-F -X -R" \
    LESS_TERMCAP_mb="$(printf "\e[01;31m")" \
    LESS_TERMCAP_md="$(printf "\e[01;38;5;74m")" \
    LESS_TERMCAP_me="$(printf "\e[0m")" \
    LESS_TERMCAP_se="$(printf "\e[0m")" \
    LESS_TERMCAP_so="$(printf "\e[43;5;30m")" \
    LESS_TERMCAP_ue="$(printf "\e[0m")" \
    LESS_TERMCAP_us="$(printf "\e[04;38;5;146m")" \
    man "${@}"
}

# Clean up path
export PATH=\
/opt/flutter/bin:\
$GOBIN:\
$GEM_HOME/bin:\
$HOME/.local/share/nvim/mason/bin:\
$HOME/.yarn/bin:\
$HOME/.npm-global/bin:\
$HOME/.cargo/bin:\
$JAVA_HOME/bin:\
$ANDROID_HOME/platform-tools:\
$ANDROID_HOME/emulator:\
$ANDROID_HOME/cmdline-tools:\
$HOME/.local/bin/scripts:\
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
