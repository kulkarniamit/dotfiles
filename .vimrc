syntax on

set tabstop=4
set hlsearch
set nu
set shiftwidth=4
set softtabstop=4
set expandtab

" Open new vertical splits on right
set splitright

" Open new horizontal splits at the bottom
set splitbelow

" Shortcut to save a document in INSERT and NORMAL mode
:inoremap <c-d> <esc>:w<cr>a
:nnoremap <c-d> :w<cr>

" Shortcut to jump to the next buffer
:nnoremap <c-n> :bn<cr>

:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

""Automatically insert header guards for header files of C/C++
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef _" . gatename ."_"
  execute "normal! o#define _" . gatename . "_ "
  execute "normal! Go#endif /* _" . gatename . "_ */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

"" Set up automatic code folding save and restore
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Custom mapping shortcut to capitalize an entire word in INSERT MODE using Ctrl+u
:inoremap <c-u> <esc>vBU<esc>A

" Create a shortcut to insert if condition in C files
:autocmd FileType c :iabbrev <buffer> iff if(){}<esc>i

" Create shortcut to load vimrc file and source it after editing
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Create abbreviations to prevent typos
:iabbrev adn and 
:iabbrev teh the 

" vim somehow confuses md code with modula2, correct it
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Jump to matching end tag
filetype plugin on
runtime macros/matchit.vim
