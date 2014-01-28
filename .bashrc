# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color'
    export LS_COLORS='di=0;96:fi=0;92:ln=1;95:so=1;91:pi=1;91:ex=1;93:bd=1;91:cd=1;91:or=1;37:mi=1;97'
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

# prompt settings
PS1_BAK=$PS1
PS1="\[\e[0;33m\][\u@\h:\W]\$\[\e[00m\] "

# proxy settings
export http_proxy="http://dev-proxy.db.rakuten.co.jp:9501/"
export https_proxy="https://dev-proxy.db.rakuten.co.jp:9501/"
export ftp_proxy="http://dev-proxy.db.rakuten.co.jp:9501/"
export RAKUTEN_SERVER_INFO="LOCAL"

alias vi='vim'
export EDITOR=vim

export LESS='-R'
export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'

alias rm='rm -i'

# telnet settings
alias dev='telnet -l arawakana01 dev-loginjp101c.db.rakuten.co.jp | tee /home/arawakana01/log/dev/`date '+%Y%m%d-%H:%M'`.log'
alias stg='telnet -l arawakana01 stg-loginjp101c.db.rakuten.co.jp | tee /home/arawakana01/log/stg/`date '+%Y%m%d-%H:%M'`.log'
alias pro='telnet -l arawakana01 loginjp101c.db.rakuten.co.jp | tee /home/arawakana01/log/pro/`date '+%Y%m%d-%H:%M'`.log'
alias dev2='telnet -l arawakana dev-loginjp201zd.zd.rakuten.co.jp | tee /home/arawakana01/log/dev/`date '+%Y%m%d-%H:%M'`.log'
alias stg2='telnet -l arawakana stg-loginjp201zd.zd.rakuten.co.jp | tee /home/arawakana01/log/stg/`date '+%Y%m%d-%H:%M'`.log'
alias pro2='telnet -l arawakana loginjp201zd.zd.rakuten.co.jp | tee /home/arawakana01/log/pro/`date '+%Y%m%d-%H:%M'`.log'

# git settings
alias g="git"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gcl="git clone --recursive"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gb="git branch"
alias gba="git branch -a"
alias gbf="git mkbr -f"
alias gbb="git mkbr -b"
alias gbr="git mkbr -r"
alias gbh="git mkbr -h"
alias gbp="git mkbr -p"
alias ga="git add"
alias gm="git merge"
alias gp="git ex push"
alias gpl="git pull"
alias grs="git reset HEAD --soft"
alias grh="git reset HEAD --hard"
alias gl="git log"
alias glg="git log --graph --pretty=format:'%C(yellow)%h%C(green)%d%Creset %s %Cblue[%ad]%C(bold blue)<%an>%Creset' --abbrev-commit --date=short --branches --remotes"
alias gd="git diff"
alias gdc="git diff --cached"
alias gr="git rebase"
alias gri2="git rebase -i HEAD~2"
alias gri3="git rebase -i HEAD~3"
alias gri4="git rebase -i HEAD~4"
alias gri5="git rebase -i HEAD~5"
alias gri6="git rebase -i HEAD~6"
alias gs="git status"
alias gst="git stash"
alias gf="git fetch"
alias gfo="git fetch origin"
alias gfa="git fetch --all"
alias gr.="git remote"
alias gr.a="git remote add"
alias gr.s="git remote show"
alias gr.rb="git remove-remote-branch"
alias gr.p="git remote prune"
alias gsm="git submodule"
alias gdt="git difftool"
alias gmt="git mergetool"
