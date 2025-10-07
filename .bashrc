# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## fix bash autocomplete in Debian with Escapex2
complete -Ef

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

XDG_CONFIG_HOME=$HOME/.config

EDITOR=vim

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
export TERM=xterm-color
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -d $HOME/.local/bin ]; then
  PATH=$PATH:$HOME/.local/bin
fi

if [ -d $HOME/bin ]; then
  PATH=$PATH:$HOME/bin
fi

function gi {
    if [ $# -eq 0 ]; then
        # some help
read -d '\n' help_msg << EOM
    gi [list|<language>]\n
      list          print a list of gitignore templates the are defined\n
      <language>    The language or tech that has files the at need\n
EOM
        echo -e $help_msg
    else
        lang=$(echo "$1" | tr '[:upper:]' '[:lower:]')
        url="https://www.toptal.com/developers/gitignore/api/${lang}"
        curl -s $url
    fi

}
export gi


#redshift -P -O 3500

# Rust 
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

if [ -d "/opt/nodejs" ]; then
    export PATH=/opt/nodejs/bin:$PATH
fi

if [ -d "$HOME/.fzf" ]; then
    export FZF_HOME="/home/jhall/.fzf"
    case ":$PATH:" in
      *":$FZF_HOME:"*) ;;
      *) export PATH="$FZF_HOME/bin:$PATH" ;;
    esac
    if [ ! -f ~/.fzf.bash ]; then
        fzf --bash > ~/.fzf.bash
    fi
    . ~/.fzf.bash
fi
        
if [ -d "/opt/go" ]; then
    export GOROOT=/opt/go
    case ":$PATH:" in
      *":$GOROOT/bin:"*) ;;
      *) export PATH="$GOROOT/bin:$PATH" ;;
    esac
fi

# node
export NODE_HOME="/opt/node/bin"
case ":$PATH:" in
  *":$NODE_HOME:"*) ;;
  *) export PATH="$NODE_HOME:$PATH" ;;
esac
# pnpm end

# pnpm
export PNPM_HOME="/home/jhall/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bash-git-prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source "$HOME/.bash-git-prompt/gitprompt.sh"
fi

# store env creds out out of source control
[ -f "$HOME/.credentials" ] && source $HOME/.credentials
