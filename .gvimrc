set guifont=Envy_Code_R:h13
set noantialias
"colorscheme desert
colorscheme mustang

" :colorscheme ir_black
set nocompatible

set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent (local to buffer)

set cursorline

set showcmd
set ruler " Show ruler

set number

" autocmd VimEnter * exe 'NERDTree' | wincmd l 

" highlight tailing whitespace
" :autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=red guibg=white
:match ExtraWhitespace /\s\+$/   
"":match ExtraWhitespace /\s\+\%#\@<!$/ " highlight except we write in that line

" jump in the next visible line with cursor, even if this just a softwrap
nnoremap j gj
nnoremap k gk

" we rather use ack than grep 
"set grepprg=ack --column
set grepformat=%f:%l:%c:%m

" fullscreen on shift+cmd+f
:set fuopt+=maxhorz

" mouse selection 
:set selection=inclusive
" :set selectmode=mouse,key

set transparency=3
