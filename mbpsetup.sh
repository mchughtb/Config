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

function inst_brew() {
    local title="$1"
    local pkg="$1"
    local cmd="brew install $1"
    local check="brew ls $1"
    inst_base "$title" "$check" "$cmd"
}


inst_base "xcode" "xcode-select -p" "xcode-select --install"
inst_base "homebrew" "which -s brew" "ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'" "brew update"

