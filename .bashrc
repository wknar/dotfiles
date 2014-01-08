# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PS1="[\u: \W]$ "
# PATH=$PATH:/usr/local/vim-7.3/bin
PATH=$PATH:$HOME/local/bin
export PATH
alias screen='$HOME/local/bin/screen'
alias sc='screen'
# alias vim='/usr/local/vim-7.3/bin/vim'
alias vim='$HOME/local/bin/vim'
alias vi='vim'
# alias ls='ls -color'
# export LS_COLORS='di=0;96:fi=0;92:ln=1;95:so=1;91:pi=1;91:ex=1;93:bd=1;91:cd=1;91:or=1;37:mi=1;97'
export LSCOLORS=fxcxgxdxbxegedabagacad
alias ls='ls -G'
alias grep='grep -ir --color'
export GREP_COLOR='00;35'

alias rm='rm -i'
