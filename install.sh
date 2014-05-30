#!/bin/bash
set -u -e

# reads a file of links to set up relative to a source and dest folder
# file is a pipe seperated list of destination|source
#	 .bashrc|my_bashrc.bash
# the filenames are relative to the source and dest folders  (to make it possible 
# to test it without trashing the real files). If unspecified the dest is $HOME
# and the source is the same folder that the script is in
# existing files will get backed up to $dest/backups

# default the source to be the same as the script
readonly thisdir=$( cd `dirname $0` && pwd )
srcdir="$thisdir"
# default dest to be home
destdir="$HOME"
config="install.cfg"
dryRun=
readonly backupname=$(date +"backups/%Y%m%d-%H%M%S")
verbose=
host=$( hostname )
os=$( uname )

function usage()
{
	cat <<-END
	Usage:
	$0 -nv -s source_dir -d dest_dir -m hostname -o os configfile
	     -n  dry run
	     -v  verbose
	     -m  override machine hostname (defaults to $host)
	     -o  override operating system (defaults to $os)
	     source_dir defaults to $thisdir
	     dest_dir defaults to $HOME
	END
}

function process_args()
{
	while getopts ":s:d:o:m:nvh" flag ; do
		case $flag in
		s) srcdir=${OPTARG%/} ;;
		d) destdir=${OPTARG%/} ;;
		n) dryRun=1 ;;
		v) verbose=1 ;;
		o) os=${OPTARG} ;;
		m) host=${OPTARG} ;;
		h) usage ; exit 1 ;;
		:) echo "ERROR: missing argument to flag [-$OPTARG]" ; usage ; exit 5 ;;
	\?) echo "ERROR: Invalid Option [-$OPTARG]" ; usage ; exit 5 ;;
esac
	done

	shift $((OPTIND-1))
	[[ -z ${1:-} ]] && { echo "ERROR: missing config file" ; usage ; exit 5 ; }
	config="$1"
}

function linker()
{
	echo LINK: "$@"
	[[ $dryRun ]] || ln -s "$@"
}

function remove()
{
	echo "BACKUP: $@"
	[[ $dryRun ]] || { mkdir -p "$destdir/$backupname" ; mv -f "$@" "$destdir/$backupname/" ; }
}

function log()
{
	if [[ $verbose ]] ; then
		 echo "$*"
	fi
}

function main() {
	log "destdir:     $destdir"
	log "srcdir:      $srcdir"
	log "config:      $config"
	log "dryRun:      $dryRun"
	log "host:        $host"
	log "os:          $os"

	[[ -r "$config" ]] || { echo "ERROR: cannot read config:$config" ; exit ; }
	[[ -d "$srcdir" ]] || { echo "ERROR: source dir not a dir?: $srcdir" ; exit ; }
	[[ -d "$destdir" ]] || { echo "ERROR: dest dir not a dir?: $destdir" ; exit ; }

	IFS='|'
	grep -v '^#' "$config" | while read dest src hostpattern ospattern; do
		log "========================"
		[[ ! -z "$src" && ! -z "$dest" ]] || continue 
		[[ "$host" == $hostpattern ]] || { log "SKIP: $src for host $hostpattern" ; continue; }
		[[ "$os" == $ospattern ]] || { log "SKIP: $src for os $ospattern" ; continue; }
		srcfile="$srcdir/$src"
		destfile="$destdir/$dest"
		[[ -r "$srcfile" ]] || { echo "ERROR: unreadable source:$srcfile" ; continue ; }
		if [[ -e "$destfile" || -L "$destfile" ]] ; then
			if [[ "$srcfile" -ef "$destfile" ]] ; then
				log "SKIP: up to date:$destfile"
				continue
			fi
			remove "$destfile" 
		else
			dir="${destfile%/*}"
			[[ -d "$dir" ]] || { log "CREATE: $dir" ; mkdir -p $dir ; }
		fi
		linker "$srcfile" "$destfile"
	done
}

process_args "$@"
main "$@"
