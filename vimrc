fun! MySys()
	if has("win32")
		return "windows"
	else
		return "mac"
endfun

" " == pathogen exclusions
" let g:pathogen_disabled = []
" if MySys() == "windows"
"     call add(g:pathogen_disabled, 'YouCompleteMe')
" else
"     call add(g:pathogen_disabled, 'YouCompleteMe')
"     call add(g:pathogen_disabled, 'clang_complete')
"     "call add(g:pathogen_disabled, 'AutoComplPop')
" endif
" 
" " == pathogen infect !
" call pathogen#infect()

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/Dropbox/Settings/vimfiles/bundle/vundle
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" from github

filetype plugin indent on     " required!

" enable ALT key for Mac
if MySys() == "mac"
    set macmeta
endif

" == usability, IME, etc
let $LANG = 'en'
set imactivatekey=C-space
set iminsert=0
set imsearch=0
set encoding=utf-8
set langmenu=en
set mouse=a
set ignorecase
set smartcase
"set nowrap
syntax on
syn match Braces display '[{}()\[\]]'
set hid
set number
set hlsearch
set incsearch
set ffs=unix
set nobackup
set noswapfile
nnoremap ; :

" automatically refresh changed files
set autoread

" == windowing
map <silent> <A-j> :cnext<CR>
map <silent> <A-k> :cprevious<CR>
map <silent> <A-c> :cclose<CR>

" == hints on wild menu
set wildchar=<Tab> wildmenu wildmode=full

" change the mapleader from \ to ,
let mapleader=","

" == CtrlP tags lookup
nnoremap <leader>s :CtrlPTag<CR>

" ,cd to change the dir to the current file
nnoremap <leader>cd :cd %:p:h<CR> 

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
"call mkdir($HOME . "/.vim")
"call mkdir($HOME . "/.vim/undodir")
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
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl,*.sl SetGLSLFileType

" == EasyGrep
let g:EasyGrepMode = 2 " track current extension
let g:EasyGrepRecursive = 1
let g:EasyGrepIgnoreCase = 1

" == NERDTree auto open and auto close
"autocmd vimenter * NERDTree
"autocmd vimenter * if !argc() | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" == sync NERDTree to current file (http://superuser.com/questions/195022/vim-how-to-synchronize-nerdtree-with-current-opened-tab-file-path)
" returns true iff is NERDTree open/active
function! rc:isNTOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" returns true iff focused window is NERDTree window
function! rc:isNTFocused()     
  return -1 != match(expand('%'), 'NERD_Tree') 
endfunction 

" calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! rc:syncTree()
  if &modifiable && rc:isNTOpen() && !rc:isNTFocused() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

autocmd BufEnter * call rc:syncTree()

" == clang_complete 
if MySys() == "windows"
	let g:clang_exec = '"' . $HOME . '\Dropbox\Settings\clang.exe'
	let g:clang_user_options = '2> NUL || exit 0"'
    let g:clang_use_library = 1
	let g:clang_library_path = $HOME . '\Dropbox\Settings\'
endif
let g:clang_auto_select = 1
let g:clang_snippets = 1
let g:clang_conceal_snippets = 1
let g:clang_snippets_engine = "clang_complete"
"let g:clang_trailing_placeholder = 1
"let g:clang_close_preview = 1
let g:clang_complete_macros = 1
let g:clang_complete_patterns = 1
let g:clang_user_options = '-std=c++11'

set conceallevel=2
set concealcursor=vin
" Complete options (disable preview scratch window,
" longest removed to aways show menu)
set completeopt=menu,menuone
" Limit popup menu height
set pumheight=20

" == Settings for CtrlP Finder
"let g:ctrlp_map = '<c-p>'
let g:ctrlp_by_filename = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$|bin$|obj$',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|\.o$\|\.d$',
  \ }

" == Settings for fswitch
nmap <silent> <Leader>o :FSHere<cr>

" == Useful abbreviations
ab //// //==================================================================

"================================
set t_Co=256
color candycode
"= color matching braces
syn match Braces display '[{}()\[\]]'
hi Braces guifg=yellow

if MySys() == "mac"
    set gfn=Andale\ Mono:h12 " Mac
    "set gfn=Menlo:h14
elseif MySys() == "windows"
    "set gfn=MS\ Gothic:h10		" Windows
    set gfn=Bitstream\ Vera\ Sans\ Mono:h9
elseif MySys() == "linux"
    "set gfn=Monospace\ 10
endif

if has("gui_running")
    set columns=170 lines=56
else
    set columns=170
endif
 
" == Fix the swap file issue with Win 7
if MySys() == "windows"
    set dir=$TEMP
endif

