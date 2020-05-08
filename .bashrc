# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

PATH=/usr/bin/git:$PATH
export PATH

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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
	color_prompt=no
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
case "$OSTYPE" in
darwin*)
  alias ls='ls -G'
  export LSCOLORS=gxfxcxdxbxegedabagacad
  ;;
linux*)
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color'
      export LS_COLORS='di=0;96:fi=0;92:ln=0;93:so=1;91:pi=1;91:ex=1;93:bd=1;91:cd=1;91:or=1;37:mi=1;97'
  fi
  ;;
esac

alias gg='git grep -iH --heading --break'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# show diff with colors
alias diff='colordiff'

# change shell to zsh
alias z='zsh'

# call vagrant
alias vg='vagrant'

# exec ruby
alias rb='ruby'

# exec python
alias py='python'
alias pysv='python -m CGIHTTPServer'

# exec flutter
alias fl='flutter'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

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

# use node
# source ~/.nvm/nvm.sh
# nvm use v0.11.13

# path to coffee
export PATH=$PATH:$HOME/.npm/coffee-script/1.7.1/package/bin

# prompt settings
function parse_git_dirty {
  [[ ! $(git status 2> /dev/null | tail -n1) =~ ^.*(nothing to commit).*$ ]] && if [[ $OSTYPE == darwin* ]]; then echo -e " \xf0\x9f\x90\xa3 "; else echo echo " ⚙ "; fi
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

PS_OK=😎
PS_NG=😂

case "$OSTYPE" in
darwin*)
# this only use in mac
export PS1='$(if [[ $? == 0 ]]; then echo -e $PS_OK ; else echo -e $PS_NG ; fi)\n\[\033[00;32m\]\u@\[\033[00;32m\]\h \[\033[00;36m\]\w \[\033[33m\]$(parse_git_branch) \[\033[00;37m\]`date +"%H:%M:%S"` \n\[\033[01;37m\]\$\[\033[00m\] '
;;
linux*)
export PS1='$(if [[ $? == 0 ]]; then echo \[\e[32m\]✔ ; else echo \[\e[31m\]✘ ; fi)\n\[\033[01;32m\]\u@\[\033[01;32m\]\h \[\033[01;36m\]\w \[\033[33m\]$(parse_git_branch) \[\033[01;37m\]`date +"%H:%M:%S"` \n\[\033[01;34m\]\$\[\033[00m\] '
;;
esac

if [ $TERM == 'screen' ]; then
  PS1=${PS1}'\[\033k\W\033\\\]'
fi

vim_version=`vim --version | head -1 | sed 's/^.*\ \([0-9]\)\.\([0-9]\)\ .*$/\1\2/'`

# git
alias g='git'
source /usr/local/etc/bash_completion.d/git-*

# other alias
alias vi='vim'
export EDITOR=vim

# less view setting
export LESS='-R'
export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
alias less=' /usr/share/vim/vim${vim_version}/macros/less.sh'

alias rm='rm -i'

# open screen
if [ $TERM != "screen" ]; then
  if [ $TERM != "dumb" ]; then
    screen -e ^z^z
  fi
fi

source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash

# neta
alias ks='echo "( ﾟзﾟ )< ｶｽ!!"'
alias bishi='echo -e "　 ∧,,∧\n （=・ω・）\n （,, ｕｕﾉ\n"'

function sudden {
  case "$OSTYPE" in
  darwin*)
    byte=`echo "$1" | awk '{ print length }'`
  ;;
  linux*)
    byte=`expr length "$1"`
  ;;
  esac
    frame=`expr $byte / 2 + 2`
    echo -n ' '
    c=0
    while [ $c -ne $frame ]
    do
      echo -n "人"
      c=`expr $c + 1`
    done
    echo -e "\n＞ $1 ＜"
    echo -n ' '
    c=0
    while [ $c -ne $frame ]
    do
      echo -n "Y^"
      c=`expr $c + 1`
    done
    echo -e
}


# read company settings
if [ -e ~/company.sh ]; then
. ~/company.sh
fi

# record iOS simulater screen shot
alias sim_ss='xcrun simctl io booted screenshot'
# record iOS simulater movie
alias sim_mv='xcrun simctl io booted recordVideo iOSsimulator_`date +%Y%m%d_%H-%M-%S`.mov'

# xcode-select
alias xs='xcode-select'
