# 
# this should work on cygwin and darwin. If the first call fails the second succeeds
#

host=$(hostname -s 2> /dev/null || hostname)


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

## add local scripts  na dhomebrew binaries to the path ahead of the osx ones

platform=$(uname -o 2> /dev/null || uname -s)
PATH="$HOME/scripts/$platform:$HOME/scripts:/usr/local/bin:$PATH"

### Set up color prompt

# txtblk='\e[0;30m' # Black - Regular
# txtred='\e[0;31m' # Red
# txtgrn='\e[0;32m' # Green
# txtylw='\e[0;33m' # Yellow
# txtblu='\e[0;34m' # Blue
# txtpur='\e[0;35m' # Purple
# txtcyn='\e[0;36m' # Cyan
# txtwht='\e[0;37m' # White

if [[ ( "x$host" == "xlaura" ) || ( "x$host" == "xlaura-en0" ) ]] ; then
	export PS1='\[\e[1;32m\]\u@\h: \w/ >\[\e[0m\] '
	export UNISONLOCALHOSTNAME=laura
elif [[ ( "x$host" == "xcookie" ) || ( "x$host" == "xcookie-wired" ) ]] ; then
	export PS1='\[\e[1;36m\]\u@\h: \w/ >\[\e[0m\] '
	export UNISONLOCALHOSTNAME=cookie
elif [[ ( "x$host" == "xfliss" ) || ( "x$host" == "xfliss-air" ) ]] ; then
	export PS1='\[\e[1;33m\]\u@\h: \w/ >\[\e[0m\] '
	export UNISONLOCALHOSTNAME=fliss
else
	export PS1='\u@\h: \w/ >\[\e[0m\] '
fi

### make the current hostname appear in the tabbed window
PROMPT_COMMAND='workd=${PWD/"$HOME"/"~"};echo -ne "\033]0;${HOSTNAME%%.*}:${workd##*/}\007" '

alias ls='ls -xF'
export VISUAL=/usr/bin/vi

## stuff that should go in inputrc perhaps?
set meta-flag on
set convert-meta off
set output-meta on


##  Amazon web services credentials are seperate and not checked-in
if [[ -f $HOME/.aws ]] ; then
	. "$HOME/.aws"
fi

## local customizations
if [[ -f $HOME/.bashrc.local ]] ; then
	. "$HOME/.bashrc.local"
fi



