#
# ~/.bash_profile: executed by bash for login shells.
#

### source the system wide bashrc if it exists

# cygwin
if [ -f /etc/bash.bashrc ] ; then
  source /etc/bash.bashrc
fi

# OSX
if [ -f /etc/bashrc ] ; then
  source /etc/bashrc
fi


#### source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

export MAGICK_HOME="/usr/local"

function tabname {
  printf "\e]1;$1\a"
}

# bash completion
if [ -f /usr/local/etc/bash_completion ]; then
	source /usr/local/etc/bash_completion
fi


