# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH=$PATH:/usr/local/vim-7.3/bin
export PATH
alias vim='/usr/local/vim-7.3/bin/vim'
alias vi='vim'
