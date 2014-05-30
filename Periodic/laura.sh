#!/bin/bash -u

export UNISONLOCALHOSTNAME=laura

export PATH=$HOME/scripts/Darwin:$HOME/scripts:$HOME/bin:$PATH
syncHost=fliss

flags="$@"
date "+%Y-%m-%d %H.%M.%S Starting Periodic"

jobRunner2.sh -m $syncHost -n "sync-documents" -t 12 $flags $HOME/scripts/sync-documents.sh
jobRunner2.sh -m $syncHost -n "sync-photos" -t 73 $flags $HOME/scripts/sync-photos.sh
jobRunner2.sh -m $syncHost -n "sync-queue" -t 25 $flags $HOME/scripts/sync-queue.sh
jobRunner2.sh -m $syncHost -n "sync-music" -t 65 $flags $HOME/scripts/sync-music.sh

date "+%Y-%m-%d %H.%M.%S Ending Periodic"

