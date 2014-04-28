version 5.3

" Do incremental searching
set incsearch
" create backup files in ~/tmp in preference to current dir
" set backupdir=c:/tmp
" Path used for   gf, completion and probably other stuff
set path=/usr/include,~/Source.$USER
" make complete search current buffer, other buffers, keyword file, sqish words, #included files
set complete=.,w,b,u,k$VIM/keywords.dic,i
" Turn on syntax highlighting (Dan prefers if these are only on in gui mode)
if has("gui_running")
    syntax on
endif

"
" These colours are okay on the light background gui or a pastel
" colour xterm. They're similar to devstudio style but with
" nice pink string literals
"
if &background == 'light'
	hi Comment		term=bold 		ctermfg=Red  		guifg=darkgreen 
	hi Constant		term=underline 	ctermfg=Magenta 	guifg=Magenta
	hi Special		term=bold 		ctermfg=Blue  		guifg=SlateBlue
	hi Identifier 	term=underline 	ctermfg=Blue  		guifg=SlateBlue
	hi Statement 	term=bold 		ctermfg=Blue  		gui=bold guifg=Brown
	hi PreProc		term=underline 	ctermfg=DarkRed  	guifg=DarkRed
	hi Type			term=underline 	ctermfg=Blue  		guifg=Blue 
	hi Ignore						ctermfg=white 		guifg=bg
endif
hi WarningMsg	term=reverse 	ctermbg=Red 	ctermfg=white  guibg=Red guifg=White
hi ErrorMsg		term=reverse 	ctermbg=Red 	ctermfg=Yellow  guibg=Red guifg=White
hi Error		term=reverse 	ctermbg=Red 	ctermfg=Yellow  guibg=Red guifg=White
hi Todo			term=standout	ctermbg=Yellow 	ctermfg=Black 	guifg=Blue guibg=Yellow
hi LineNr 		term=NONE

"
" Make syntax higlighting work in color xterms  (i.e rxvt)
"
if $COLORTERM =~ "rxvt" || $TERM =~ "color"
  :if has("terminfo")
  :  set t_Co=8
  :  set t_Sf=[3%p1%dm
  :  set t_Sb=[4%p1%dm
  :else
  :  set t_Co=8
  :  set t_Sf=[3%dm
  :  set t_Sb=[4%dm
  :endif
  syntax on
endif
" These are as close as I could get to devstudio style indenting
set cinoptions=g0
set cindent
" Tabstop = 8
set ts=8
" Shiftwidth = 4
set sw=4
"
" use = to reindent the selected lines for C++   (default is to use /bin/fmt which is not
" good for C++)  use    =]]   in vim to reformat a whole function
"
set equalprg=
set nolisp

"
" build project
" by hitting F7. Requires a Makefile in pwd
"
map <F7> :make
map! <F7> :make

"
" next error after a build
"
map <F4> :cn
map! <F4> :cn

" 
" Previous error in a build    
"
map <S-F4> :cp
map! <S-F4> :cp

" open filename under cursor
" you can do this with    gf    instead which is better   (read : go-file)
"
map <F12> :e <cWORD>
"
" bash style command completion
"
set wildmode=longest,list,list:full     " Bash-vim wildcard behavior
"
" Splits the window and opens the sister file (source-header)
" use ^W^X to shuffle the order
function! Switch()
	let ext=expand("%:e")
	if ext=="cpp" 
		execute("new " . expand("%:r" ) . ".h")
	elseif ext=="h" 
		execute("new " . expand("%:r" ) . ".cpp")
endfunc

" 
" Puts a dated & named comment at the beginning of the current line
"
function! Dated()
	let cmt = "// " . $USER . " " . strftime("%Y%m%d") . ":"
	let cmd = ":s#^#&" . cmt
	execute( cmd )
endfunc

"
" Create a command which calls this function
"
command! Dated call Dated()

"
" if file is in a buffer then switch to it. Otherwise open file from disk
"
function! BufferOrEdit(filename)
	if( bufexists(a:filename) )
		execute('buf ' . a:filename)
	else
		execute('e ' . a:filename)
	endif
endfunc
" 
" Switch to the sister file or open if buffer not open already
"
function! Exchange()
	let ext=expand('%:e')
	let basename=expand('%:r' ) 
	if ext=='cpp'   
		call BufferOrEdit(expand('%:r' ) . '.h')
	elseif  ext=='cc'   
		call BufferOrEdit(expand('%:r' ) . '.h')
	elseif ext=='c' 
		call BufferOrEdit(expand('%:r' ) . '.h')
	elseif ext=='hpp' 
		call BufferOrEdit(expand('%:r' ) . '.h')
	elseif ext=='h' 
		if(filereadable(basename . '.cpp'))
		    call BufferOrEdit( expand('%:r' ) . '.cpp')
		elseif(filereadable(basename . '.cc'))
		    call BufferOrEdit( expand('%:r' ) . '.cc')
		elseif(filereadable(basename . '.c'))
		    call BufferOrEdit( expand('%:r' ) . '.c')
		else
		    call BufferOrEdit( expand('%:r' ) . '.cpp')
		endif
	endif
endfunc

"
" Find the definition of a C++ method. Simplistic implementation:
" looks in the .cpp file for ::methodname
"
function! FindDefinition(methodname)
    let ext=expand('%:e')
    if(ext=='h')
    	call Exchange()
    endif
    execute('/' . '::' . a:methodname . '\>')
endfunc

"   _h  : open sister file a new window
"   _x  : switch to editing sister file
map _h :call Switch()a
map _x :call Exchange()

"
"make shift-insert work in the gui as well as in the xterm. to paste the x-selection (in insert mode)
" since Sh-Ins never gets to vim in an xterm this is safe for both gui & normal.  Telnet might be fun though :-)
"  The second line make it work in command mode as well.
map!  <S-Insert>   "*gp
cmap  <S-Insert>   *

"
" edit my vimrc file in a new window
"
map _v :new $VIM/_vimrc

    
"
" Make the title of the window include the hostname
"
"if has("gui_running")
"    auto BufEnter * let &titlestring =  "Vim - " . expand("%:p")
"else
"    auto BufEnter * let &titlestring = $USER . '@' . hostname() . " - " . expand("%:p")
"endif
    
"
" go to the definition of the method under the cursor (ish)
"
map _d wb"gyw:call FindDefinition('g')<CR>zz

"
" for some reason cmd files don't get the corret syntax file
au BufNewFile,BufRead *.cmd setf dosbatch
au BufNewFile,BufRead *.log setf flogger

" Turn on loading of the indent file when the filetype is detected
" this is good for XML and C++ files
filetype indent on

" add hyphen and colon to the iskeyword var so that xml NCNames and QNames
" can be part of the completion options
set iskeyword+=:,-

" use NT command shell rather than the MKS one
set shell=c:\winnt\system32\cmd.exe


"
"" use diff from the VIM folder
"set diffexpr=VimDirDiff()
"function VimDirDiff()
"   let opt = ""
"   if &diffopt =~ "icase"
"	 let opt = opt . "-i "
"   endif
"   if &diffopt =~ "iwhite"
"	 let opt = opt . "-b "
"   endif
"   silent execute "!" . $VIM . "/diff -a " . opt . v:fname_in . " " . v:fname_new . " > " . v:fname_out
"endfunction
"
"
