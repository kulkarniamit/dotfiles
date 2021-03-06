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

" Set a mapleader
" Replace ',' with anything comfortable
let mapleader=","

"" Cycle through open buffers
:nnoremap bc :bnext<cr>

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

augroup AutoSaveFolds
" Make sure we've a '~/.vim/' directory with write permissions for user
" Views are stored in '~/.vim/view` directory by default
" More info: 
" :help mkview
" :help autocmd!
  autocmd!
  au BufWinLeave *.* mkview
  au BufWinEnter *.* silent loadview
augroup END

" Create abbreviations to prevent typos
:iabbrev adn and
:iabbrev teh the

" vim somehow confuses md code with modula2, correct it
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Jump to matching end tag
filetype plugin on
runtime macros/matchit.vim

" Shortcut to codefold a C function
:nnoremap <leader>} :mark a<cr>%zf'a

" Shortcut to jump to the previous enclosing '{' in a block (C language)
" Useful to jump to beginning of a function by repeated use of this shortcut
" [[ cannot be used because it requires function block braces to be in column 1
" and we don't have it in first column most of the times
:nnoremap cc [{

" Find and open a file buffer
function! Findandopen(fname, command)
"    echom a:fname
    let l:flist = split(system('find . -name '.a:fname), '\n')
    if len(l:flist) < 1
        echo a:fname." not found"
        return
    endif
    let l:chosen_file = l:flist[0]
    for i in l:flist
        execute "badd ".i
    endfor
    execute a:command." ".l:chosen_file
endfunction

" Find and open a file in vertical split
command! -nargs=* Vf :call Findandopen(<f-args>, "vsp")

" Find and open a file buffer
command! -nargs=* Bo :call Findandopen(<f-args>,"buffer")

" Find and open tab page of a file
command! -nargs=* Ot :call Findandopen(<f-args>,"tabedit")
