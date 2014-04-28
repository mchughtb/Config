version 5.3


" 
" Pick up main standard rc file
"

" source $VIM/vimrc

"
" Make 'F' format a paragraph of text  (can replace fmt with gnroff here to get double justification)
"
map F !}fmt

" This is not in the main stuff because it might be considered dangerous
set autowrite

"  Stuff from http://www.cs.indiana.edu/hyplan/kinzler/home/.vimrc
" let myvimdir="~/etc/vim
" let mysyntaxfile=myvimdir."/syntax.vim"
" let myscriptsfile=myvimdir."/scripts.vim"
" let mypagerfile=myvimdir."/pager.vim"
" let comment="#"


" find current word in files in working directory
" map <F2> "zyw:grep z * \|& tee errors.err
 
":cf

"
" Show the difference between the buffer and the file
" on the disk  (i.e what edits you have made in this window)
" only works on unix
" command! Bdiff so $VIM/buffer_diff


" Change to directory of current file
map _cd :cd %:h

"
" edit main vimrc file in a new window
"
map _V :new $VIM/vimrc

" make control S work like under windows. This won't work in an xterm but will in the gui version
" and stops it inserting literal ^S
map  :w<CR>
map!  :w<CR>


" 
" I like my make to be quiet and supress errors
"
" set makeprg=qmake

" 
" The banner that Terry puts on cpp files looks shit if wrap is on
"
set nowrap

" set backupdir=c:/tmp,c:/temp,f:/tmp



" 
" Toggle line numbers on & off with M-N
"
 map <M-n> :set invnu<CR>

" Mapping underscore in insert mode is a bad move as it is a valid char in the text.
" map! _N :call ToggleNu()

" Get Control-Tab to work a  bit like dev studio
map <C-Tab> :bN


"
" Get rid of annoying long messages when writing files which 
" mean you have to hit return
"
set shortmess=tolf


" make sure current dir is in the path so that gf works in ~/Source
" also add include dirs here 
" These should really be in the buf-load for c/C++ files 
" but that's the bread we have to butter most often.
" set path+=,.,/software/external/CC/include/CC,/software/external/CC/include/cc,/software/external/rogue7.0.8
set path+=,.,
"
" Some pretty standard typing/spelling corrections
"
abbrev inculde include
abbrev indleude include
abbrev incldue include
abbrev EQSTring EQString
abbrev EQarray EQArray
abbrev Wanring Warning
abbrev wanring warning
abbrev EQGRid EQGrid
abbrev EQGRidWidget EQGridWidget
abbrev EQPOsitionABC EQPositionABC
abbrev EQPOsitionWindow EQPositionWindow
abbrev EQPOsitionSource EQPositionSource
abbrev EQPOsitionFilter EQPositionFilter
abbrev EQPOsitionView EQPositionView
abbrev fro from
abbrev frmo from
abbrev CComBSR CComBSTR
cabbrev b buf
"
" Map tab and shift tab to do in/un-dent when in visual selection mode
" like in devstudio
vmap <Tab> >>
vmap <S-Tab> <<

" 
" If in gui mode this adds the current file to a recent file list under the file menu
"
function! AddRecentMenuItem()
    	let ext=expand("%:e")
	let short=expand("%:r")
    	let long=expand("%")
	let mnu= "File.Recent." . short . "\\." . ext
	execute("amenu " . mnu . "<Tab>:e :buf " . long . "<CR>")
endfunc

"
"  Setup stuff for when we load a squish buffer
"
function! SetupSquishEditor()
    execute("set syntax=sql")
    abbrev posid posId
    abbrev firm_Acct_mnem firm_acct_mnem
    abbrev firm_acct_mnme firm_acct_mnem
    " Ignorecase makes for better completion in sqsh
    set ic
endfunc

" 
" This makes ALT-b behave a bit like a window menu. It lists the buffers and waits
" for a number
"
map <M-b> :buffers<CR> :buffer<Space>

" 
" Each time a buffer is entered it is added to the recent file menu
"
" autocmd BufEnter *.h  call AddRecentMenuItem()
" autocmd BufEnter *.cpp  call AddRecentMenuItem()
" autocmd BufEnter Project.*  call AddRecentMenuItem()

" 
" Set up some file types which VIM dosen't know about
" to get syntax hl in sqsh and for Project files
autocmd BufEnter sqsh-edit.*  call SetupSquishEditor()
" autocmd BufEnter Project*  so $VIM/syntax/make.vim
autocmd BufEnter make.*  so $VIM/syntax/make.vim
autocmd BufEnter .alias  so $VIM/syntax/csh.vim
autocmd BufEnter ~/vim/*  so $VIM/syntax/vim.vim
autocmd BufEnter .dbxrc  set syn=sh
autocmd BufEnter *.dsr	set syn=vb
autocmd BufEnter *.asp	set syn=vb
autocmd BufEnter *.dsm	set syn=vb
autocmd BufEnter *.frm	set syn=vb
autocmd BufEnter *.bas	set syn=vb
autocmd BufEnter *.cls	set syn=vb
autocmd BufEnter *.reg	cal SetSyn("ishd")


if &background == 'light'
	hi Comment		term=bold 	ctermfg=Red  		guifg=darkgreen 
	hi shComment	term=bold 	ctermfg=Blue  		guifg=darkgreen 
	hi Constant		term=underline 	ctermfg=Magenta 	guifg=Magenta
	hi Special		term=bold 	ctermfg=Blue  		guifg=SlateBlue
	hi Identifier 	term=underline 	ctermfg=Blue  		guifg=SlateBlue
	hi Statement 	term=bold 	ctermfg=Blue  		gui=bold guifg=Brown
	hi PreProc		term=underline 	ctermfg=DarkRed  	guifg=DarkRed
	hi Type		term=underline 	ctermfg=Blue  		guifg=Blue 
	hi Ignore				ctermfg=white 		guifg=bg
endif
hi WarningMsg		term=reverse 	ctermbg=Red 	ctermfg=white  guibg=Red guifg=White
hi ErrorMsg		term=reverse 	ctermbg=Red 	ctermfg=Yellow  guibg=Red guifg=White
hi Error		term=reverse 	ctermbg=Red 	ctermfg=Yellow  guibg=Red guifg=White
hi Todo			term=standout	ctermbg=Yellow 	ctermfg=Black 	guifg=Blue guibg=Yellow
hi LineNr 				ctermfg=black 
hi StatusLine 				ctermbg=Yellow 		guibg=yellow



set sw=4
set ts=8
com! Scratch new c:/tmp/scratch
com! Include so $VIM/smart_include
com! Expand so $VIM/cpp_expand
com! NewHtml r $VIM/htmlTemplate.html


" Note CTRL-A increments the number at/in front of the cursor.
" CTRL-X decrements

"
" This makes the mouse behave like in an xterm which is my preference
" as I rarely use it for selection, just cut/paste
"
set mouse=a


" See :help command  for information on how to create new commands
"


function! Decl2Def(class)
    " delete anything after a comment  like //
     "execute(a:firstline . ',' a:lastline 's@//.*$@@')
    execute('s@//.*$@@/a')
    " Remove any leading whitespace
    execute('s/^[ 	]*//a')
    " Get rid of any virtual or static specifications
    execute('s/^virtual|^static//a')
    " Put in the class name in front of the identifier followed by a
    " a prenthesis
    execute('s/\~\<\h\w*(/' . a:class . '::&/a')
    "execute('s/ \+/ ' . a:class . '::/')
    " get rid of the semi-colon and put in some braces
    execute('s/;$/
{
}
/a')
endfunc


map <F7> :!make

"
" Comment out the selection in visual mode
"
vmap  di/*P*/


" This makes completion better but messes up searching for the current word. Hmm!
" set iskeyword=a-z,A-Z,48-57,_,.,-,>,:

"
" going to try this for a while and see how I get on with it.
" ideally I'd like completion to be insensetive and searchihng sensitive
"
set ic

" make the status line at the bottom two high to reduce press key messages
" and so showmode and ruler don't overwrite the last message
"
" set ch=2


"
" better way of achieving the same thing. WHo care what mode we're in anyway :-)
set noshowmode

 "little baby tabs
set ts=4
set sw=4

" no ugly toolbar
set guioptions-=T
set guifont=Lucida_Console:h8
" create swap files on a local disk. Esp. when using network
" drives and production servers!

" some nice xml abbreviations
"
ab xsiuri http://www.w3.org/2001/XMLSchema-instance
ab xsluri http://www.w3.org/1999/XSL/Transform
ab xsduri http://www.w3.org/2001/XMLSchema

" make VIM incompatible with vi
" for multi-level undo and other goodies
set nocompatible
