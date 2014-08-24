
* Change install.cfg format to use colon more like /etc/passwd  @done
* Add fields for architecture (match regexp to uname output)   @done
	and hostname (match regexp to hostname)
	[[ "Darwin" == D* ]] && echo yes   # note lack of quoting on wildcard

* Use .profile for common variables (PATH) shared by sh and bash. see debian setup
  for the order things get called   @done
* option to copy the files rather than link them so it works from a network share under windows  @done
* Use submodules for the vim stuff


