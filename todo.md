
* Change install.cfg format to use colon more like /etc/passwd
* Add fields for architecture (match regexp to uname output)   @done
	and hostname (match regexp to hostname)
	[[ "Darwin" == D* ]] && echo yes   # note lack of quoting on wildcard
	
