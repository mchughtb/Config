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
	tmux new-session -A -s "$name"
}

script=${0##*/}
[[ "$script" == "tat.bash" ]] && tat "$@"




