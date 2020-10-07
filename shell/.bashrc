#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -h --group-directories-first'
alias path='echo $PATH | tr ":" "\n"'
PS1='[\u@\h \W]\$ '

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"



[ -f ~/.fzf.bash ] && source ~/.fzf.bash
