
setlocal autoindent
setlocal tw=78                  " text width 78 chars
setlocal formatoptions=tcnr     " hard wrap and format while typing
setlocal cc=81                  " display red line at char 81

" treat numbered lists (1. 1.2), - and * and [1] footnotes as lists
" when reformatting
let &formatlistpat='^\s*\(\d\+\.\)\+\s\+\|^\s*[-*+]\s\+\|^\s*\[\d\+\]\s\+\|^\[^.*\]:\s\+'
