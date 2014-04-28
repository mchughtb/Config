#!/bin/bash
set -u -e

thisdir=$( cd `dirname $0` && pwd )
srcdir="$thisdir"
destdir="$HOME"
config="config.cfg"
dryRun=
backupname=$(date +"backups/%Y%m%d-%H%M%S")
verbose=

function usage()
{
	cat <<-END
	Usage:
	$0 -nv -s source_dir -d dest_dir configfile
	     -n  dry run
	     -v  verbose
	     source_dir defaults to $thisdir
	     dest_dir defaults to $HOME
	END
}

function process_args()
{
	while getopts ":s:d:nvh" flag ; do
	  case $flag in
	    s) srcdir=${OPTARG%/} ;;
	    d) destdir=${OPTARG%/} ;;
	    n) dryRun=1 ;;
	    v) verbose=1 ;;
	    h) usage ; exit 1 ;;
	    :) echo "missing argument to flag [-$OPTARG]" ; usage ; exit 5 ;;
	   \?) echo "Invalid Option [-$OPTARG]" ; usage ; exit 5 ;;
	  esac
	done

	shift $((OPTIND-1))
	[[ -z ${1:-} ]] && { echo "missing config file" ; usage ; exit 5 ; }
	config="$1"
}

function linker()
{
	echo "ln -s $@"
	[[ $dryRun ]] || ln -s "$@"
}

function remove()
{
	echo "backup: $@"
	[[ $dryRun ]] || { mkdir -p "$destdir/$backupname" ; mv -f "$@" "$destdir/$backupname/" ; }
}

function log()
{
	if [[ $verbose ]] ; then
		 echo $*
	fi
}

function main() {
	log "destdir:$destdir"
	log "srcdir:$srcdir"
	log "config:$config"
	log "dryRun:$dryRun"

	[[ -r "$config" ]] || { echo "ERROR: cannot read config:$config" ; exit ; }
	[[ -d "$srcdir" ]] || { echo "ERROR: source dir not a dir?: $srcdir" ; exit ; }
	[[ -d "$destdir" ]] || { echo "ERROR: dest dir not a dir?: $destdir" ; exit ; }

	IFS='|'
	grep -v '^#' "$config" | while read dest src ; do
		[[ ! -z "$src" && ! -z "$dest" ]] || continue
		log "========================"
		srcfile="$srcdir/$src"
		destfile="$destdir/$dest"
		log "$destfile -> $srcfile"
		[[ -r "$srcfile" ]] || { echo "ERROR: unreadable source:$srcfile" ; continue ; }
		if [[ -e "$destfile" ]] ; then
			if [[ "$srcfile" -ef "$destfile" ]] ; then
				log "SKIP: up to date:$destfile"
				continue
			fi
			[[ -w "$destfile" ]] || { echo "ERROR: target not writable:$destfile" ; continue ; }
			remove "$destfile" 
		else
			dir="${destfile%/*}"
			[[ -d "$dir" ]] || { log "creating dir:$dir" ; mkdir -p $dir ; }
		fi
		linker "$srcfile" "$destfile"
	done
}

process_args "$@"
main "$@"
