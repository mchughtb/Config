#
# .bashrc run by bash for non-login shells
# 

# this should work on cygwin and darwin. If the first call fails the second succeeds
# set this on non-interactive shells as well as unison needs this
# by convention dns will give    name-en0  or name-wifi so strip the hyphen onwards
host=$(hostname -s 2> /dev/null || hostname)
export UNISONLOCALHOSTNAME=${host%%-*}

# Everything else is only for interactive shells
case $- in
    *i*) ;;
      *) return;;
esac

#
# Set up bash histroy to work across sessions
#

# Make bash append rather than overwrite the history on disk
 shopt -s histappend
# Don't put duplicate lines in the history.
 HISTCONTROL="ignoreboth"
 unset HISTFILESIZE
 HISTSIZE=10000
 HISTIGNORE='&:??'
 export HISTCONTROL HISTSIZE HISTIGNORE

# Write to the hist file when the shell exists
_archive_history ()
{
	history -a
}

trap _archive_history EXIT

# colour prompts
if [[ ( "x$host" == "xlaura" ) || ( "x$host" == "xlaura-en0" ) ]] ; then
	export PS1='\[\e[1;32m\]\u@\h: \w/ >\[\e[0m\] '
elif [[ ( "x$host" == "xcookie" ) || ( "x$host" == "xcookie-wired" ) ]] ; then
	export PS1='\[\e[1;36m\]\u@\h: \w/ >\[\e[0m\] '
elif [[ ( "x$host" == "xfliss" ) || ( "x$host" == "xfliss-air" ) ]] ; then
	export PS1='\[\e[1;33m\]\u@\h: \w/ >\[\e[0m\] '
else
	export PS1='\u@\h: \w/ >\[\e[0m\] '
fi

### make the current hostname appear in the tabbed window
PROMPT_COMMAND='workd=${PWD/"$HOME"/"~"};echo -ne "\033]0;${HOSTNAME%%.*}:${workd##*/}\007" '

alias ls='ls -xF'
export VISUAL=/usr/bin/vim

## stuff that should go in inputrc perhaps?
set meta-flag on
set convert-meta off
set output-meta on


## local customizations
if [[ -f $HOME/.bashrc.local ]] ; then
	. "$HOME/.bashrc.local"
fi

# TMUX specific settings
if [[ -n "$TMUX" ]] ; then
	# make mvim use a vim server with the session name from tmux
	mvim=$( which mvim )
	session=$( tmux display-message -p '#S' )
	eval " function mvim()  { \
		[[ -n \$@ ]] && reattach-to-user-namespace $mvim --servername $session --remote-tab-silent \$@ ; \
		[[ -n \$@ ]] || ( $mvim --serverlist | grep -qi $session || reattach-to-user-namespace $mvim --servername $session );\
	} "
fi

if [[ -f "$HOME/.bashrc.d/tat.bash" ]] ; then
	. "$HOME/.bashrc.d/tat.bash"
fi

# changes the title of the terminal
function tabname {
printf "\e]1;$1\a"
}

# bash completion
if [ -f /usr/local/etc/bash_completion ]; then
	source /usr/local/etc/bash_completion
fi


