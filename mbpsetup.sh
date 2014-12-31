#!/bin/bash -eu

function inst_base() {
    local title="$1"
    local check="$2"
    local cmd="$3"
    local post="${4:-""}"
    echo "================ START       $title ==============="
    if $check > /dev/null ; then
        echo "$title: already installed"
    else
        echo "================ INSTALL     $title ==============="
        $cmd
        [[ -z "$post" ]] || $post
    fi
    echo "================ END         $title ==============="
}

inst_base "xcode" "xcode-select -p" "xcode-select --install"
inst_base "homebrew" "which -s brew" "ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'" "brew update"

