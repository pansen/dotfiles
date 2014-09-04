syntax on
set backspace=2
set nocompatible
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
syntax match Special "\t"
set selection=exclusive
set ruler           " show the cursor position all the time
set hlsearch        " highlight search matches
set incsearch       " jump to the first occurence while typing the search pattern

" disable backup files
set nobackup
set noswapfile

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
" autoindent advanced version
:set cindent

:set virtualedit=insert

" set leader key (previously \ to #)
let mapleader = "#"


set enc=utf-8
:vnoremap <Tab> >gv
:vnoremap <S-Tab> <gv

autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
" python autocomplete, maybe that one is necessary: http://www.vim.org/scripts/script.php?script_id=1542
autocmd FileType python set omnifunc=pythoncomplete#Complete

au BufRead,BufNewFile *.json set filetype=json

" trim tailing space for selected files
" autocmd BufWritePre *.php,*.py :%s/\s*$//

let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let $Tlist_Ctags_Cmd='/usr/local/bin/ctags'

" taglist toggle
map <F3> :TlistToggle<CR>

" command-t plugin
map <F4> :CommandT<CR>

map <F1> :bprevious<CR>  " map F1 to open previous buffer
map <F2> :bnext<CR>      " map F2 to open next buffer

" f8 will hightlight all words under the cursor
:nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
"
" json formatter, seen:
" http://visibletrap.blogspot.de/2010/05/vim-how-to-format-and-syntax-highlight.html
map <leader>jf  <Esc>:%!json_xs -f json -t json-pretty<CR>

" highlight tailing whitespace          
":autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=red guibg=blue
:match ExtraWhitespace /\s\+$/          
":match ExtraWhitespace /\s\+\%#\@<!$/ " highlight except we write in that line
match ErrorMsg '\%>80v.*'

" Keep n lines below and above the cursor
set scrolloff=15

" rst preview
:command Rst :!rst2html-2.7.py "%" > /tmp/rstprev.html && open /tmp/rstprev.html
:nnoremap <C-p><C-r> :Rst<CR>

" markdown (.md) preview
:nnoremap <C-p><C-m> :Mm<CR>

" token from 
" http://stackoverflow.com/questions/741814/move-entire-line-up-and-down-in-vim
function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

noremap <silent> <c-s-up> :call <SID>swap_up()<CR>
noremap <silent> <c-s-down> :call <SID>swap_down()<CR>

" disable autowrap forever
" set tw=0
" set wrap
" :set wrap linebreak textwidth=0
set nolinebreak
" :verbose set tw?
