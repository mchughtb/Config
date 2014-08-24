#
# ~/.bash_profile: executed by bash for login shells.
#


## add local scripts and dhomebrew binaries to the path ahead of the osx ones
platform=$(uname -o 2> /dev/null || uname -s)


## source the system wide bashrc if it exists
if [ -s /etc/bash.bashrc ] ; then	# cygwin
  source /etc/bash.bashrc
fi
if [ -s /etc/bashrc ] ; then		# OSX
  source /etc/bashrc
fi

PATH="$HOME/scripts/$platform:$HOME/scripts:/usr/local/bin:/usr/bin:$PATH"

## source the users bashrc if it exists
if [ -s "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

##  Amazon web services credentials are seperate and not checked-in
if [[ -s "$HOME/.aws" ]] ; then
	source "${HOME}/.aws"
fi


