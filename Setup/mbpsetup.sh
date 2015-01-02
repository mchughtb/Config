#!/bin/bash -eu

dryrun=1

function once() {
    local title="$1"
    local check="$2"
    local cmd="$3"
    local post="${4:-""}"
    echo "================ START       $title ==============="
    if $check > /dev/null ; then
        echo "$title: already installed"
    else
        $cmd
        if [[ -z "$post" ]] ; then
            $post
        fi
    fi
    echo "================ END         $title ==============="
}

function inst_brew() {
    local title="$1"
    local pkg="$1"
    local cmd="brew install $1"
    local check="brew ls $1"
    local post="${4:-""}"
    once "$title" "$check" "$cmd"
}

function inst_cask() {
    local title="$1"
    local pkg="$1"
    local cmd="brew cask install $1"
    local check="brew cask ls $1"
    once "$title" "$check" "$cmd"
}


function inst_gem() {
    local title="$1"
    local pkg="$1"
    local cmd="/usr/local/bin/gem install $1"
    local check="/usr/local/bin/gem search -i $1"
    once "$title" "$check" "$cmd"
}

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
once "xcode" "xcode-select -p" "xcode-select --install"
once "homebrew" "which -s brew" "ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\" " "brew update"
inst_brew "caskroom/cask/brew-cask" "brew cask update"

for file in $@ ; do
    source $file
done
