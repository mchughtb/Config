#!/bin/bash -u

export UNISONLOCALHOSTNAME=kat

export PATH=$HOME/scripts/Darwin:$HOME/scripts:$HOME/bin:$PATH

syncHost=fliss

flags="$@"
date "+%Y-%m-%d %H.%M.%S Starting Periodic"

jobRunner2.sh -m $syncHost -n "sync-documents" -t 13 $flags $HOME/scripts/sync-documents.sh
jobRunner2.sh -m $syncHost -n "sync-photos" -t 73 $flags $HOME/scripts/sync-photos.sh
jobRunner2.sh -m $syncHost -n "sync-queue" -t 23 $flags $HOME/scripts/sync-queue.sh
jobRunner2.sh -m $syncHost -n "sync-music" -t 61 $flags $HOME/scripts/sync-music.sh
# jobRunner2.sh -m $syncHost -n "sync-imovie" -t 1341 $flags $HOME/scripts/sync-imovie.sh

date "+%Y-%m-%d %H.%M.%S Ending Periodic"

