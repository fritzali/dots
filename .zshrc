# ~/.zshrc



# enable colors:
autoload -U colors && colors
alias "ls"="ls --color=auto" # display colors when listing files


# change prompt:
PROMPT='%B%F{011}[%f%F{009}%T%f%F{011} > %f%F{010}%n%f%F{011} > %f%F{012}%~%f%F{011}]$%f%b %F{015}%'


# history in cache directory:
SAVEHIST=1000000
HISTSIZE=1000000
if [ ! -e "$HOME/.cache/zsh/history" ]; then
  mkdir -p $HOME/.cache/zsh/ && touch $HOME/.cache/zsh/history
fi
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
HISTFILE=$HOME/.cache/zsh/history
alias "history"="history --f" # display time stamps in history


# basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # enable for hidden files


# vi/vim mode:
bindkey -v
export KEYTIMEOUT=1


# vim keys for tab completion:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char


# change cursor shape for different vi modes: 
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate insert mode as keymap
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # use beam shape cursor on startup
preexec() { echo -ne '\e[6 q' ;} # each new line uses beam shape cursor


# automatically update window title:
function precmd () {
  echo -ne "\033]0;$(pwd | sed -e "s;^$HOME;~;")" "– $(echo $TERM | sed -e 's/.*/\u&/')"
}


# define alias for moving files to trash:
alias del="mkdir -p $HOME/.trash/ && mv $@ -t $HOME/.trash/"


# set up anaconda:
. $HOME/.local/anaconda3/etc/profile.d/conda.sh


# append to path: 
# export PATH="$HOME/.local/texlive/2022/bin/x86_64-linux:$PATH"
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"

# install ruby gems:
export GEM_PATH="$HOME/.gem/ruby/3.3.5/bin"
export PATH="$GEM_PATH:$PATH"
