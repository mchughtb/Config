#!/bin/bash

# run command in a tmux window called "output"
# create the window if it is not already there
# when run outside a tmux session just run the command normally
function tmux_run {
    if [[ -n ${TMUX:-""} ]] ; then
        local window
        window=$( tmux list-windows | grep ": output" | cut -d':' -f1 )
        if [[ -z $window ]] ; then
            window=$( tmux new-window -P -n output )
        fi
        tmux send-keys -t "$window" " $*" C-m
    else
        "$@"
    fi
}

