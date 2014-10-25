# returns th name required to scp this
# file from a remote machine
function scpname() {
	echo $USER@$(hostname -s):"$(pwd)/$1"
}

script=${0##*/}
[[ "$script" == "scp-name.bash" ]] && scpname "$@"




