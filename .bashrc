# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH=$PATH:/usr/local/vim-7.3/bin
export PATH
alias vim='/usr/local/vim-7.3/bin/vim'
alias vi='vim'
export LSCOLORS=gxfxcxdxbxegedabagacad
#alias ls='ls -G'
alias grep='grep -ir --color'
export GREP_COLOR='00;35'
