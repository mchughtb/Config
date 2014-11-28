
- [x] Change install.cfg format to use colon more like /etc/passwd  @done
- [x] Add fields for architecture (match regexp to uname output)   @done
      and hostname (match regexp to hostname)
      [[ "Darwin" == D* ]] && echo yes   # note lack of quoting on wildcard

- [ ] Use .profile for common variables (PATH) shared by sh and bash. see debian setup
      for the order things get called   @done
- [x] option to copy the files rather than link them so it works from a 
      network share under windows  @done
- [ ] Use diff to detect change target files in copy mode
- [ ] Use git subtree or Vundle for vim plugins

- [ ] Inverse matching of the arch/host regexp so can have one rull for X 
      and another for not X
- [x] Use a junction for linking under windows
      cmd.exe //c mklink //j targetdir sourcedir

