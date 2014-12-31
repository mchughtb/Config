
for brew in ruby "git-sh" ; do
    inst_brew "$brew"
done

# #
# #  Nice brews
# #
# for brew in node reattach-to-user-namespace ssh-copy-id terminal-notifier wget nmap xmlstartlet imagemagick exiftool colordiff subversion trash multimarkdown ; do
#     inst_brew "$brew"
# done

# #
# #  Nice casks
# #
# for cask in dash dashlane cord launchrocket vlc virtualbox transmission xamarin-studio adium vagrant xquartz ; do
#     inst_cask "$cask"
# done

# #
# #  Quick look casks
# #
# for cask in betterzipql qlcolorcode qlstephen quicklook-json qlprettypatch quicklook-csv suspicious-package webp-quickloo; do
#     inst_cask "$cask"
# done
for gem in bundler ; do
    inst_gem bundler
done
