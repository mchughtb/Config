#
# ~/.bash_profile: executed by bash for login shells.
#



## source the system wide bashrc if it exists
if [ -s /etc/bash.bashrc ] ; then	# cygwin
  source /etc/bash.bashrc
fi
if [ -s /etc/bashrc ] ; then		# OSX
  source /etc/bashrc
fi


## source the users bashrc if it exists
if [ -s "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

##  Amazon web services credentials are seperate and not checked-in
if [[ -s "$HOME/.aws" ]] ; then
	source "${HOME}/.aws"
fi

## add RVM as a function if it's present
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

