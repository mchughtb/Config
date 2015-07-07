#!/bin/sh



set -u
export PATH=$HOME/scripts/Darwin:$HOME/scripts:$HOME/bin:$PATH
#date "+%Y-%m-%d %H.%M.%S Skipping skipping skipping
#exit"
date "+%Y-%m-%d %H.%M.%S Starting Periodic"

flags="$@"

# jobRunner2.sh -n "tv-rssd" -t 17 $flags $HOME/scripts/tv-rss.sh -D
# jobRunner2.sh -n "tv-rss" -t 16 $flags $HOME/scripts/tv-rss.sh
#jobRunner2.sh -n "eztv-rss" -t 13 $flags $HOME/scripts/eztv-rss.sh -s $HOME/Movies/favourites.txt
#jobRunner2.sh -n "eztv-rss-yesterday" -t 360 $flags $HOME/scripts/eztv-rss.sh -s $HOME/Movies/favourites.txt -t 1
jobRunner2.sh -n "picasa-ucecrjf" -t 1442  $flags $HOME/scripts/photo-fetch.sh -d "$HOME/Pictures/ServerFiles/Originals/%Y/%Y-%m-01-KelliPicasa" -u ucecrjf -s picasa -L KelliPicasa
jobRunner2.sh -n "flickr-les" -t 1444  $flags $HOME/scripts/photo-fetch.sh -s flickr -d "$HOME/Pictures/ServerFiles/Originals/%Y/%Y-%m-01-LesFlickr" -u "45232884@N02" -L LesFlickr
jobRunner2.sh -n "flickr-kelli" -t 1445  $flags $HOME/scripts/photo-fetch.sh -s flickr -d "$HOME/Pictures/ServerFiles/Originals/%Y/%Y-%m-01-KelliPicasa" -u "41352893@N00" -L KelliFlickr
jobRunner2.sh -n "flickr-dan" -t 1447  $flags $HOME/scripts/photo-fetch.sh -s flickr -d "$HOME/Pictures/ServerFiles/Originals/%Y/%Y-%m-01-DanFlickr" -u "49392099@N02" -L DanFlickr
jobRunner2.sh -n "small-photos" -t 61 $flags $HOME/scripts/photo-thumbnails.sh "$HOME/Pictures/Photos/Originals" Originals SmallPhotos
jobRunner2.sh -n "sync-appletv" -t 15  $flags $HOME/scripts/sync-appletv.sh
jobRunner2.sh -m debs -n "backup-fliss" -t 121  $flags $HOME/scripts/backup-fliss.sh
#jobRunner2.sh -n "move-watched-shows" -t 1449 $flags $HOME/scripts/tv-movewatched.sh
date "+%Y-%m-%d %H.%M.%S Ending Periodic"
