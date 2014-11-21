set guioptions-=T

set mouse=a													" Enable basic mouse behavior such as resizing buffers.

nmap <A-{> :tabprev<CR>
nmap <A-}> :tabnext<CR>
nmap <A-n> :tabnew<CR>

" put wd in the window title
set titlestring=%{fnamemodify(getcwd(),':~')}

" Source local cutomizations
if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif
