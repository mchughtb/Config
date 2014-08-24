
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


