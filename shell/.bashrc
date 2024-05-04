#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#alias ls='ls --color=auto -h --group-directories-first'
alias ls="exa"
alias path='echo $PATH | tr ":" "\n" | nl'
alias syserrors="journalctl -p 3 -xb"
alias sysderrors="systemctl --failed"
PS1='[\u@\h \W]\$ '

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# Load Angular CLI autocompletion.
source <(ng completion script)
source /usr/share/nvm/init-nvm.sh
