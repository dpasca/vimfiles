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

if MySys() == "windows"
"    set shell=cmd
"    set shellcmdflag=/c
"    set shellslash " default to forward slash, like for Unix
endif

" OLD
"if has('nvim')
"    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"endif

if (has("termguicolors"))
    set termguicolors
endif

set rtp=$MYVIMFILES,$VIM,$VIMRUNTIME
"let g:plug_threads = 1
call plug#begin($HOME . '/.vim/plugged')

" -- From github and vim-scripts
" Automatically run autocomplete. No need for ctrl-n/p
Plug 'eparreno/vim-l9'
Plug 'othree/vim-autocomplpop'

" Switch color schemes with F8
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-colorscheme-switcher'
"
Plug 'morhetz/gruvbox'
" Example to search & replace after a grep: Qdo %s/src/repl
Plug 'henrik/vim-qargs'
" GitGrep for fast grepping
Plug 'tjennings/git-grep-vim'
" Syntax checker
"Plug 'scrooloose/syntastic'
" Find files, MRU, tags, etc.
Plug 'ctrlpvim/ctrlp.vim'
" Tagbar
Plug 'majutsushi/tagbar'
" List modified files in a git repo
Plug 'jasoncodes/ctrlp-modified.vim'
" File browser
Plug 'scrooloose/nerdtree'
" Switch src/header
Plug 'derekwyatt/vim-fswitch'
" Operators highlight
Plug 'Valloric/vim-operator-highlight'
" Improved syntax highlight for C++
Plug 'octol/vim-cpp-enhanced-highlight'
" Quick list and location list toggler
Plug 'Valloric/ListToggle'
" NOTE problems with vim-fugitive ?
"Plug 'DirDiff.vim'
" For Git
Plug 'tpope/vim-fugitive'
" Add commands like Remove, Move, Find
Plug 'tpope/vim-eunuch'
" For Git Gutter to work well with gVim + msys (temp file path issue)
Plug 'xolox/vim-misc'
Plug 'xolox/vim-shell'
Plug 'xolox/vim-notes'
" Git gutter, with stage and revert in <leader>hs / hr
Plug 'airblade/vim-gitgutter'
" Improved status line
Plug 'bling/vim-airline'
" Hexmode
" Plug 'fidian/hexmode'
" Expand and restrict regions progressively
Plug 'terryma/vim-expand-region'
" #ifdef highlighting
Plug 'vim-scripts/ifdef-highlighting'
" :AsyncRun make ... etc
Plug 'skywind3000/asyncrun.vim'

" set the language menu (later than this won't work)
set langmenu=en

call plug#end()            " required

filetype plugin indent on    " required!

" enable ALT key for Mac
if exists('+macmeta')
    set macmeta
endif

" == usability, IME, etc
let $LANG = 'en'
if !has('nvim')
    set imactivatekey=C-space
endif
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
    map <silent> <C-S-j> :cnext<CR>
    map <silent> <C-S-k> :cprevious<CR>
    map <silent> <C-S-c> :cclose<CR>
else
    map <silent> <A-j> :cnext<CR>
    map <silent> <A-k> :cprevious<CR>
    map <silent> <A-c> :cclose<CR>
endif

" shortcuts for ListToggle
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" additional tabs nagivation
nnoremap gr :tabprevious<CR>
nnoremap <s-tab> :tabprevious<CR>
nnoremap , :tabnext<CR>

" simplified splits nagivation
" Using C-hjkl to move around
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
inoremap <C-h> <C-w><C-h>
inoremap <C-j> <C-w><C-j>
inoremap <C-k> <C-w><C-k>
inoremap <C-l> <C-w><C-l>
tnoremap <C-h> <C-\><C-N><C-w><C-h>
tnoremap <C-j> <C-\><C-N><C-w><C-j>
tnoremap <C-k> <C-\><C-N><C-w><C-k>
tnoremap <C-l> <C-\><C-N><C-w><C-l>

" select next/prev using C-j/k instead of C-n/p
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("k"))

" == hints on wild menu
set wildchar=<Tab> wildmenu wildmode=full

" change the mapleader from \ to Space
let mapleader="\<Space>"

" CtrlP tags lookup
nnoremap <leader>s :CtrlPTag<CR>
" <leader>[w]f to find input for GitGrep
nnoremap <leader>wf :GitGrep -w <cword><Space>
nnoremap <leader>f :GitGrep<Space>
" <leader>g to find a tag
nnoremap <leader>g :exec("tag ".expand("<cword>"))<CR>
" <leader>cd to change the dir to the current file
nnoremap <leader>cd :cd %:p:h<CR> 

" ctrlp-modified shortcuts (NOTE: not working in Windows ?)
map <Leader>m :CtrlPModified<CR>
map <Leader>M :CtrlPBranch<CR>

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
 
" == share clipboard Windows and Linux shell
set clipboard^=unnamed,unnamedplus

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

" == AsyncRun for :Make and vim-fugitive
" see: https://github.com/skywind3000/asyncrun.vim/wiki/Cooperate-with-famous-plugins#fugitive
"command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
"
"if exists(':Make') == 2
"    noautocmd Make
"else
"    silent noautocmd make!
"    redraw!
"    return 'call fugitive#cwindow()'
"endif

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
let g:cpp_member_variable_highlight = 1

" == vim-airline
" no warnings about trailing, because it includes empty lines (!)
"let g:airline#extensions#whitespace#checks = [ 'indent' ]
let g:airline_section_a = '' " no mode
let g:airline_section_x = '' " no file type
let g:airline_section_y = '' " no file encoding/format
let g:airline_section_z = '' " no file location

" == vim-notes
let g:notes_directories = ['$HOME/Dropbox/Notes']
let g:notes_suffix = '.txt'

" ==
"set conceallevel=2
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
let g:ctrlp_lazy_update = 350

" == Settings for fswitch
nmap <silent> <Leader>o :FSHere<cr>

" F9 launches python ( http://stackoverflow.com/a/18948530 )
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

" == Useful abbreviations
iab ==== //==================================================================

"================================
" http://vim.wikia.com/wiki/Use_eval_to_create_dynamic_templates
augroup templates
  au!
  " read in template files
  autocmd BufNewFile *.* silent! execute '0r $MYVIMFILES/templates/skeleton.'.expand("<afile>:e")

  " parse special text in the templates after the read
  autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END

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
    " using 'c_auto' for 'const auto'
    au VimEnter * au Syntax * syntax keyword cppSTLtype c_auto
endif

"== disable autocomplpop in terminal mode
au BufEnter * if &buftype == 'terminal' | AcpDisable | setlocal bufhidden=hide | endif
au BufLeave * if &buftype == 'terminal' | AcpEnable | endif

hi Braces guifg=#a0ff60

hi Search guibg=brown guifg=NONE
hi Normal guibg=#121212

" for vim op highlight plugin
let g:ophigh_color_gui = "#F6FF00"

" ==
let g:gitgutter_async = 1
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
"let g:gitgutter_grep_command = 'grep -e'
nmap <Leader>hr <Plug>(GitGutterUndoHunk)
" NOTE: we set the highlight down here to override others
highlight GitGutterAdd    guifg=#00aa00
highlight GitGutterChange guifg=#aaaa00
highlight GitGutterDelete guifg=#ff2222

"=== Morning set
"color default
"hi Braces guifg=#900000
"hi Normal guibg=#f0f0f0
"let g:ophigh_color_gui = "#a00000"
"set gfn=Lucida\ Console:h8

"================================
if MySys() == "mac"
    set gfn=Consolas:h9
    "set gfn=Menlo:h14
elseif MySys() == "windows"
    "set gfn=MS\ Gothic:h10
    "set gfn=Bitstream\ Vera\ Sans\ Mono:h9
    set gfn=Inconsolata:h9
elseif MySys() == "linux"
    "set gfn=DejaVu\ Sans\ Mono\ 10
    "set gfn=Inconsolata\ 8
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
endif

let g:shell_fullscreen_items=0

" == Fix the swap file issue with Win 7
"if MySys() == "windows"
"    set dir=$TEMP
"endif

" DirectX
"if has("directx") && $VIM_USE_DIRECTX != '0'
"    set renderoptions=type:directx,geom:1,taamode:1
"endif

