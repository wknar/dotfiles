# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH=$PATH:/usr/local/vim-7.3/bin
export PATH
alias sc='screen'
alias vim='/usr/local/vim-7.3/bin/vim'
alias vi='vim'
alias ls='ls --color'
export LS_COLORS='di=1;36:fi=0:ln=1;95:so=1;91:pi=1;91:ex=93:bd=1;91;46:cd=1;91:or=1;37:mi=1;37:*.rpm=1;92'
alias grep='grep -ir --color'
export GREP_COLOR='00;35'
