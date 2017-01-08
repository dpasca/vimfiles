fun! MySys()
    if has("win32")
        return "windows"
    elseif has("mac")
        return "mac"
    else
        return "linux"
endfun

set nocompatible               " be iMproved
filetype off                   " required!

set rtp=$MYVIMFILES,$VIM,$VIMRUNTIME
set rtp+=$MYVIMFILES/bundle/vundle
call vundle#begin()

" let Vundle manage Vundle
"Plugin 'VundleVim/vundle', {'name': '$MYVIMFILES/bundle/vundle'}

" -- From github and vim-scripts
" Automatically run autocomplete. No need for ctrl-n/p
Plugin 'AutoComplPop'
" Updates tags automatically (needs existing ctags)
Plugin 'AutoTag'
" Switch color schemes with F8
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-colorscheme-switcher'
" Example to search & replace after a grep: Qdo %s/src/repl
Plugin 'henrik/vim-qargs'
" GitGrep for fast grepping
Plugin 'tjennings/git-grep-vim'
" clang-driven autocomplete and jump
Plugin 'Rip-Rip/clang_complete'
" Find files, MRU, tags, etc.
Plugin 'kien/ctrlp.vim'
" File browser
Plugin 'scrooloose/nerdtree'
" Switch src/header
Plugin 'derekwyatt/vim-fswitch'
" Improved syntax highlight for C++
Plugin 'octol/vim-cpp-enhanced-highlight'
" Operators highlight
Plugin 'Valloric/vim-operator-highlight'
" Quick list and location list toggler
Plugin 'Valloric/ListToggle'
" NOTE problems with vim-fugitive ?
"Plugin 'DirDiff.vim'
" For Git
Plugin 'tpope/vim-fugitive'
" Add commands like Remove, Move, Find
Plugin 'tpope/vim-eunuch'
" Git gutter, with stage and revert in <leader>hs / hr
Plugin 'airblade/vim-gitgutter'
" Improved status line
Plugin 'bling/vim-airline'
" Hexmode
Plugin 'fidian/hexmode'
" Expand and restrict regions progressively
Plugin 'terryma/vim-expand-region'

" set the language menu (later than this won't work)
set langmenu=en

call vundle#end()            " required
filetype plugin indent on    " required!

" enable ALT key for Mac
if exists('+macmeta')
    set macmeta
endif

" == usability, IME, etc
let $LANG = 'en'
set imactivatekey=C-space
set iminsert=0
set imsearch=0
set encoding=utf-8
set mouse=a
set ignorecase
set smartcase
"set nowrap
syntax on
"syn match Braces display '[{}()\[\]]'
set hid
set number
set hlsearch
set incsearch
set ffs=unix,dos
set nobackup
set noswapfile
nnoremap ; :
set scrolloff=1 " keep 1 line below and above the cursor
set laststatus=2 " always show the status line

" automatically refresh changed files
set autoread

" == windowing A-j/k/c to select and close the QuixFix window
" enable ALT key for Mac
if exists('+macmeta') && !has("gui_running")
    " special case for when running in OS X terminal (iTerm 2)
    map <silent> �?:cnext<CR>
    map <silent> �?:cprevious<CR>
    map <silent> ç :cclose<CR>
else
    map <silent> <A-j> :cnext<CR>
    map <silent> <A-k> :cprevious<CR>
    map <silent> <A-c> :cclose<CR>
endif

" shortcuts for ListToggle
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" additional tab nagivation with ctrl-j/k or gr
nnoremap gr :tabprevious<CR>
nnoremap <c-h> :tabprevious<CR>
nnoremap <c-l> :tabnext<CR>

" select next/prev using C-j/k instead of C-n/p
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("k"))

" == hints on wild menu
set wildchar=<Tab> wildmenu wildmode=full

" change the mapleader from \ to ,
let mapleader="\<Space>"

" CtrlP tags lookup
nnoremap <leader>s :CtrlPTag<CR>
" <leader>[w]f to find input for GitGrep
nnoremap <leader>wf :GitGrep -w <cword><Space>
nnoremap <leader>f :GitGrep<Space>
" <leader>g to find a tag (C-] is taken over by clang_complete)
nnoremap <leader>g :exec("tag ".expand("<cword>"))<CR>
" <leader>cd to change the dir to the current file
nnoremap <leader>cd :cd %:p:h<CR> 

" shortcut to quickly find a file in NERDTree
nmap <leader>p :NERDTreeFind<CR>

" setup for vim-expand-region
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" No sound on errors
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set tm=500

" == shortcuts
"map <C-TAB> :b#<CR>
 
" == share clipboard with system (Windows only ?)
set clipboard=unnamed
 
" == word wrapping
set linebreak
 
" == tab spaces
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
set smartindent

" == disble auto comment on newline !
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
 
" == persistent undo
if !isdirectory($HOME . "/.vim")
    call mkdir($HOME . "/.vim", "p")
endif
if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
endif
set undodir=$HOME/.vim/undodir
set undofile
set undolevels=5000 "maximum number of changes that can be undone
set undoreload=50000 "maximum number lines to save for undo on a buffer reload

" == file types
au BufReadPost *.sl set syntax=cpp
"au BufReadPost *.glsl set syntax=cpp

command SetGLSLFileType call SetGLSLFileType()
function SetGLSLFileType()
  for item in getline(1,10)
    if item =~ "#version 400"
      execute ':set filetype=glsl400'
      break
	else "if item =~ "#version 330"
      execute ':set filetype=glsl330'
      break
    endif
  endfor
endfunction
au BufNewFile,BufRead *.frag,*.vert,*.tesc,*.tese*.fp,*.vp,*.glsl,*.sl SetGLSLFileType

" == enhanced cpp syntax highlight options
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" == clang_complete 
let g:clang_user_options = '-std=c++11'
if MySys() == "windows"
    " NOTE: https://github.com/Rip-Rip/clang_complete/wikia
    "   docs say to put " ad begin of clang_exec and at end of
    "   clang_user_options but it's no longer working
    let g:clang_exec = $MYCLANGLIBPATH . '/clang.exe'
    let g:clang_library_path = '"' . $MYCLANGLIBPATH . '"'
    let g:clang_user_options .= '2> NUL || exit 0'
endif
let g:clang_use_library = 1
let g:clang_library_path = $MYCLANGLIBPATH
let g:clang_auto_select = 1
let g:clang_snippets = 1
let g:clang_conceal_snippets = 1
let g:clang_snippets_engine = "clang_complete"
"let g:clang_trailing_placeholder = 1
"let g:clang_close_preview = 1
let g:clang_complete_macros = 1
let g:clang_complete_patterns = 1

" == vim-airline
" no warnings about trailing, because it includes empty lines (!)
"let g:airline#extensions#whitespace#checks = [ 'indent' ]
let g:airline_section_a = '' " no mode
let g:airline_section_x = '' " no file type
let g:airline_section_y = '' " no file encoding/format
let g:airline_section_z = '' " no file location

" ==
let g:gitgutter_grep_command='grep -e'

" ==
set conceallevel=2
set concealcursor=vin
" Complete options (disable preview scratch window,
" longest removed to aways show menu)
set completeopt=menu,menuone
" Limit popup menu height
set pumheight=20

" == Settings for CtrlP Finder
let g:ctrlp_by_filename = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$|bin$|obj|data$|Debug$|Release$|RelWithDebInfo$',
  \ 'file': '\v\.(exe|so|dll|o|d|jar|class)$',
  \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

" == Settings for fswitch
nmap <silent> <Leader>o :FSHere<cr>

" F9 launches python ( http://stackoverflow.com/a/18948530 )
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

" == Useful abbreviations
ab //// //==================================================================

"================================
" No toolbar, no menu bar, no scroll bars
set guioptions=i

"================================
" COLORS
set t_Co=256
color candycode
" color molokai

"= color matching braces
"syn match Braces display '[{}()\[\]]'
if has('autocmd') && has('syntax')
    au VimEnter * au Syntax * syn match Braces display '[{}()\[\]<>]'
endif

hi Braces guifg=#a0ff60
hi Search guibg=brown guifg=NONE
hi Normal guibg=#121212
" for vim op highlight plugin
let g:ophigh_color_gui = "#F6FF00"

"=== Morning set
"color default
"hi Braces guifg=#900000
"hi Normal guibg=#f0f0f0
"let g:ophigh_color_gui = "#a00000"
"set gfn=Lucida\ Console:h8

"================================
if MySys() == "mac"
    set gfn=Consolas:h10
    "set gfn=Menlo:h14
elseif MySys() == "windows"
    "set gfn=MS\ Gothic:h10
    "set gfn=Bitstream\ Vera\ Sans\ Mono:h9
    set gfn=Inconsolata:h9
elseif MySys() == "linux"
    set gfn=DejaVu\ Sans\ Mono\ 10
endif

" Window sizing
" see http://vim.wikia.com/wiki/Maximize_or_set_initial_window_size
if has("gui_running")
    if MySys() == "windows"
        " Use ~x on an English Windows version or ~n for French.
        au GUIEnter * simalt ~x
    else
        set lines=999 columns=999
    endif
"else
"    " This is console Vim.
"    if exists("+lines")
"      set lines=56
"    endif
"
"    if exists("+columns")
"      set columns=170
"    endif
endif

" == Fix the swap file issue with Win 7
if MySys() == "windows"
    set dir=$TEMP
endif

