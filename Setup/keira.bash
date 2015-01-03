
#
# Must haves brew
#
for brew in "bash-completion" git tmux the_silver_searcher ; do
    inst_brew "$brew"
done

#
# Must haves cask
#
for cask in macvim google-chrome flux spectacle unison ; do
    inst_cask "$cask"
done

# Show the ~/Library folder
chflags nohidden ~/Library

inst_cask picasa
inst_cask vlc
# inst_cask scansnap-manager
inst_cask citrix-receiver
inst_cask skype
inst_cask dropbox
inst_cask spotify



#
#v Quick look casks
#
inst_cask betterzipql
inst_cask qlcolorcode
inst_cask qlstephen
inst_cask quicklook-json
inst_cask qlprettypatch
inst_cask quicklook-csv
inst_cask suspicious-package




