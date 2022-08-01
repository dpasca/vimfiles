" F2 will launch clang-format
" h / cpp / hpp will read this plugin file as well
"nnoremap <silent> <F2> :py3file /usr/local/opt/clang-format/share/clang/clang-format.py<CR>
"map <C-I> :py3file /usr/local/opt/clang-format/share/clang/clang-format.py<CR>
"imap <C-I> <c-o>:py3file /usr/local/opt/clang-format/share/clang/clang-format.py<CR>

" define the sign for breakpoints
highlight Breakpoints guifg=#000000 guibg= #ff8c1a
sign define breakpoints text=◯ texthl=Breakpoints

" Add mappings for :Step and :Over
noremap <silent> <F10> :Over<CR>
noremap <silent> <F11> :Step<CR>

function! ToggleBrakepoint()
    execute "let b_list=sign_getplaced(\"" . expand("%:p")  . "\", {'lnum' :" .   line(".")  . ", 'name' : 'breakpoints' , 'group' : 'breakpoints' })"
    if len(b_list[0].signs)==0
        " no breakpoint defined
        execute "sign place 2 line=" . line(".") . " name=breakpoints group=breakpoints file=" . expand("%:p")
    else
        " remove the breakpoint
        execute "sign unplace group=breakpoints"
    endif
endfunction

function! WriteGdbBreakpointFile(fname)
    " if a global file exists, overwrite the function caller
    if(exists(g:breakpoints_file))
        let a:fname=g:breakpoints_file
    endif
    call writefile(["# Breakpoints"], a:fname)
    let cur_buffer = bufnr('%')
    for buf in getbufinfo({'buflisted':1})
        execute "let b_list=sign_getplaced(\"" . buf.name  . "\", {'group' : 'breakpoints'})"
        for item in b_list[0].signs
            call writefile(["break " . buf.name . ':' . item.lnum], a:fname, "a")
        endfor
    endfor
endfunction

function! SaveBreakpoints()
    " if a global file exists, overwrite the function caller
    if(exists("g:breakpoints_file"))
        call WriteGdbBreakpointFile (g:breakpoints_file)
    else
        call WriteGdbBreakpointFile ('.breakpoints.gdb')
    endif
endfunction

function! LoadBreakpoints()
    " if a global file exists, overwrite the function caller
    if(exists("g:breakpoints_file"))
        let fname=g:breakpoints_file
    else
        let fname='.breakpoints.gdb'
    endif
    let s:lines=readfile(fname)
    " first line is a comment, start from 1
    let index=1
    while index < len(s:lines)
        let b=split(split(s:lines[index])[1], ':')
        if bufexists(b[0])
            execute "sign place 2 line=" . b[1] . " name=breakpoints group=breakpoints file=" . b[0]
        endif
        let index = index + 1
    endwhile
endfunction

" Add toggle breakpoints
noremap <F9> :call ToggleBrakepoint() <CR>
" Clear all breakpoints
noremap <leader><F9>d :call sign_unplace('breakpoints') <CR>
" Save All breakpoints
noremap <leader><F9>s :call SaveBreakpoints() <CR>
" Load breakpoints - note buffer must be loaded
noremap <leader><F9>l :call LoadBreakpoints() <CR>

