#!/bin/bash -eu

# Perform an action once.
#
#    $1 - title of the action to print
#    $2 - command to check if this action has already been done
#    $3 - command to perform the action (only called if check is false)
#    $4 - (optional) command to execute after $3 (only called if $3 is sucess)
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

# install a homebrew package
#
#    $1 - name of package
function inst_brew() {
    local title="$1"
    local pkg="$1"
    local cmd="brew install $pkg"
    local check="brew ls $pkg"
    once "$title" "$check" "$cmd"
}

# install a homebrew cask
#
#    $1 - name of cask
function inst_cask() {
    local title="$1"
    local pkg="$1"
    local cmd="brew cask install $pkg"
    local check="brew cask ls $pkg"
    local post="${2:-""}"
    once "$title" "$check" "$cmd" "$post"
}

# install a ruby gem
#
#    $1 - name of gem
function inst_gem() {
    local title="$1"
    local pkg="$1"
    local cmd="/usr/local/bin/gem install $pkg"
    local check="/usr/local/bin/gem search -i $pkg"
    once "$title" "$check" "$cmd"
}

# Install xcode commandline, homebrew, homebrew cask
#
function bootstrap() {
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    once "xcode" "xcode-select -p" "xcode-select --install"
    if which -s brew ; then
        echo "homebrew already installed"
    else
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && brew update
        echo "homebrew installed"
    fi
    inst_brew "caskroom/cask/brew-cask" "brew cask update"

}

bootstrap

for file in "$@" ; do
    source "$file"
done
