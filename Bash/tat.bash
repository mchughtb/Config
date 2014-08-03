# Create a tmux session but attach if it already exists
# if arg is a directory change to it and attach to session
# if arg is empty assume pwd
# if arg is not a directory treat it as an explicit session name
function tat() {
	local arg=${1:-""}
	if [[ -d "$arg" ]] ; then
		cd "$arg"
		arg=$(pwd)
	fi
	if [[ -z "$arg" ]] ; then
		arg=$(pwd)
	fi
	local name=${arg##*/}
	if tmux has-session -t "$name" 2> /dev/null ; then
		echo "Attaching to existing session: $name"
		tmux attach-session -t "$name"
	else
		tmux new-session -s "$name"
	fi
}

script=${0##*/}
[[ "$script" == "tat.bash" ]] && tat "$@"




