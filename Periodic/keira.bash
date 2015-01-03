#!/bin/bash
set -u

script_dir=$HOME/Documents/scripts
export PATH=$script_dir/Darwin:$script_dir:$HOME/bin:$PATH

date +"%F-%T PERIODIC-START"

flags="$@"

jobRunner2.sh -v -p -n Config -t 15 -s fliss $flags $script_dir/sync-config.sh

jobRunner2.sh -p -n MovieQueue -t 15 -s fliss $flags $script_dir/sync-queue.sh 
jobRunner2.sh -p -n Documents -t 17 -s fliss $flags $script_dir/sync-documents.sh 
#jobRunner2.sh -p -n Photos -t 12 -s fliss $flags $script_dir/sync-photos.sh 

date +"%F-%T PERIODIC-END"
