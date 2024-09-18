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
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
"
Plug 'srcery-colors/srcery-vim'

Plug 'morhetz/gruvbox'
" Example to search & replace after a grep: Qdo %s/src/repl
Plug 'henrik/vim-qargs'
" GitGrep for fast grepping
Plug 'tjennings/git-grep-vim'
" ripgrep (NOTE: it benefits from skywind3000/asyncrun.vim)
"Plug 'mattia72/vim-ripgrep'
" Syntax checker
"Plug 'scrooloose/syntastic'
" Find files, MRU, tags, etc.
"Plug 'ctrlpvim/ctrlp.vim'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" preview for fzf
"Plug 'yuki-yano/fzf-preview.vim'
"Plug 'chengzeyi/fzf-preview.vim'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" FZF file search with ctrl-p
nnoremap <C-p> :FZF<CR>
" FZF tags lookup
nnoremap <leader>s :Tags<CR>
" FZF history
nnoremap <leader>h :History<CR>

Plug 'ludovicchabant/vim-gutentags'

" List modified files in a git repo
"Plug 'jasoncodes/ctrlp-modified.vim'
" File browser
Plug 'scrooloose/nerdtree'
" Switch src/header
Plug 'derekwyatt/vim-fswitch'
" Operators highlight
Plug 'Valloric/vim-operator-highlight'
" Improved syntax highlight for C++
Plug 'bfrg/vim-cpp-modern'
" Improved syntax highlight for JavaScript
Plug 'pangloss/vim-javascript'
" Quick list and location list toggler
Plug 'Valloric/ListToggle'
" Dir Diff
Plug 'ZSaberLv0/ZFVimDirDiff'
Plug 'ZSaberLv0/ZFVimJob' " required
Plug 'ZSaberLv0/ZFVimIgnore' " optional, but recommended for auto ignore setup
" Plug 'ZSaberLv0/ZFVimBackup' " optional, but recommended for auto backup

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
" Themes for the status line
Plug 'vim-airline/vim-airline-themes'
" Hexmode
" Plug 'fidian/hexmode'
" Expand and restrict regions progressively
Plug 'terryma/vim-expand-region'
" #ifdef highlighting
Plug 'vim-scripts/ifdef-highlighting'
" :AsyncRun make ... etc
Plug 'skywind3000/asyncrun.vim'
" highlights and removes whitespaces
Plug 'ntpeters/vim-better-whitespace'
" allow local configuration file by project
Plug 'embear/vim-localvimrc'
" local settings for tabs, etc.
Plug 'editorconfig/editorconfig-vim'
" CoPilot support
Plug 'github/copilot.vim'

" NOTE: will have to check again if Cody finally works
" " Plenary required for Cody below
" Plug 'nvim-lua/plenary.nvim'
" " Sourcegraph Cody support
" Plug 'sourcegraph/sg.nvim', { 'do': 'nvim -l build/init.lua' }

" Tabby
Plug 'TabbyML/vim-tabby'
let g:tabby_keybinding_accept = '<Tab>'

" Navigate in tmux panes with ctrl-hjkl and \
Plug 'christoomey/vim-tmux-navigator'
" Plugin to format tables
Plug 'dhruvasagar/vim-table-mode'

" Enable Copilot by default
autocmd BufRead,BufNewFile * let b:copilot_enabled = v:true

" https://codeinthehole.com/tips/vim-and-github-copilot/
" Other filetypes that should use CoPilot
"let g:copilot_filetypes = {
"    \ 'gitcommit': v:true,
"    \ 'markdown': v:true,
"    \ 'yaml': v:true
"    \ }

" Conditionally disable Copilot for large files and notify
autocmd BufReadPre *
    \ let f=getfsize(expand("<afile>"))
    \ | if f > 200000 || f == -2
    \ | let b:copilot_enabled = v:false
    \ | echo "Copilot disabled for this buffer due to file size."
    \ | endif

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript', 'c', 'css', 'go', 'java', 'json', 'lua', 'php', 'ruby', 'rust', 'sql', 'typescript', 'vim', 'yaml']

" Support for Jupyter notebooks
Plug 'goerz/jupytext.vim'
let g:jupytext_fmt = 'py'

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
set nobomb
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
set cursorline
"set cursorcolumn

" automatically refresh changed files
set autoread
" necessary for neovim
if has('nvim')
    " au FocusGained * :checktime
    " https://www.reddit.com/r/neovim/comments/f0qx2y/comment/fgxa0f8/?utm_source=share&utm_medium=web2x&context=3
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
    " notification after file change
    autocmd FileChangedShellPost *
      \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
endif

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" IMPORTANT NOTE: enable ALT key in iTerm2:
"  Preferences -> Profiles -> Keys -> Left Option Key: Esc+
" == windowing A-j/k/c to select and close the QuixFix window
map <silent> <A-j> :cnext<CR>
map <silent> <A-k> :cprevious<CR>
map <silent> <A-c> :cclose<CR>

" my current xterm case... whatever works
map <silent> ê :cnext<CR>
map <silent> ë :cprevious<CR>
map <silent> ã :cclose<CR>

" localvimrc configuration
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0
let s:localvimrc_whitelist = '.*'

" shortcuts for ListToggle
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" settings for EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
au FileType gitcommit let b:EditorConfig_disable = 1

" additional tabs nagivation
nnoremap gr :tabprevious<CR>
nnoremap <s-tab> :tabprevious<CR>
nnoremap M :tabprevious<CR>
nnoremap , :tabnext<CR>

" support for s-tab in xterm
" https://neovim.io/doc/user/cmdline.html
"cmap <Esc>[1~ <C-P>
"https://stackoverflow.com/questions/2745428/how-to-capture-shift-tab-in-vim
exe 'set t_kB=' . nr2char(27) . '[Z'

" modify the split behavior
"set splitbelow
set splitright

" if we are in GUI mode, then we cannot rely on vim-tmux-navigator
if has('gui_running')
    " simplified splits nagivation
    " Using C-hjkl to move around
    nnoremap <C-h> <C-w><C-h>
    nnoremap <C-l> <C-w><C-l>
    nnoremap <C-j> <C-w><C-j>
    nnoremap <C-k> <C-w><C-k>
    inoremap <C-h> <C-w><C-h>
    inoremap <C-l> <C-w><C-l>
    inoremap <C-j> <C-w><C-j>
    inoremap <C-k> <C-w><C-k>
endif

" Disabled j/k since they conflict with the FZF panel when using C-j/k
tnoremap <C-h> <C-\><C-N><C-w><C-h>
tnoremap <C-l> <C-\><C-N><C-w><C-l>
"tnoremap <C-j> <C-\><C-N><C-w><C-j>
"tnoremap <C-k> <C-\><C-N><C-w><C-k>

" select next/prev using C-j/k instead of C-n/p
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("k"))

" == hints on wild menu
set wildchar=<Tab> wildmenu wildmode=full wildoptions=pum

" change the mapleader from \ to Space
"let mapleader="\<Space>"
nnoremap <space> <Nop>
map <Space> <Leader>

" === BEGIN Guten Tags
" Project root markers
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" Tag file name
let g:gutentags_ctags_tagfile = 'tags'
" Enable ctags module
let g:gutentags_modules = ['ctags']
" Cache directory
let g:gutentags_cache_dir = expand('~/.cache/tags')
" Extra ctags arguments
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q', '--c++-kinds=+px', '--c-kinds=+px', '--PHP-kinds=+cf', '--Go-kinds=+cf', '--output-format=e-ctags']
" Exclude patterns
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.json', '*.xml', '*.phar', '*.ini', '*.rst', '*.md', '*.bin', '*storage/*', '*vendor/*', '*node_modules/*', '*public/*']
" Enable asynchronous updates
let g:gutentags_async = 1
" Enable incremental updates
let g:gutentags_ctags_incremental = 1
" Enable incremental updates
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
" Filetypes
let g:gutentags_ctags_extra_args += ['--languages=Python,JavaScript,TypeScript,C,C++,Rust,Go']
" Status line indicator
set statusline+=%{gutentags#statusline()}

" Set tags option to include local tags file
set tags=./tags;,tags;

if executable("rg")
    nnoremap <leader>wf :grep -w <cword><Space>
    nnoremap <leader>f :grep<Space>

    " Add --max-filesize=10M to avoid searching in files larger than 10MB
    set grepprg=rg\ --vimgrep\ --no-heading\ --glob=!tags\ --max-filesize=10M
    set grepformat=%f:%l:%c:%m,%f:%l:%m
else
    nnoremap <leader>wf :GitGrep --recurse-submodules -w <cword><Space>
    nnoremap <leader>f :GitGrep --recurse-submodules<Space>
endif

" <leader>g to find a tag
nnoremap <leader>g :exec("tag ".expand("<cword>"))<CR>
" <leader>cd to change the dir to the current file
nnoremap <leader>cd :cd %:p:h<CR>

" ctrlp-modified shortcuts (NOTE: not working in Windows ?)
"map <Leader>m :CtrlPModified<CR>
"map <Leader>M :CtrlPBranch<CR>

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
set list
"set listchars=tab:┌┬┐
set listchars=tab:..
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

" == use 'Arun' for an AsyncRun that can be recalled with F5
" useful to quickly recall a build && exec
" example:
"   type once:
"     arun ./build.sh && ./run.sh
"   ..and recall with F5
let g:asyncrun_silent = 0

function! s:AsyncRunRepeatLast()
  if exists('s:last_async_command')
    execute 'AsyncRun' s:last_async_command
  else
    echo 'No previous AsyncRun command found'
  endif
endfunction

nnoremap <F5> :call <SID>AsyncRunRepeatLast()<CR>
command! -nargs=+ Arun execute 'let s:last_async_command = <q-args>' | execute 'AsyncRun' <q-args>

augroup asyncrun_events
  autocmd!
  autocmd User AsyncRunStart if exists('s:last_async_command') | echo "Command: " . s:last_async_command . " started." | endif
  autocmd User AsyncRunStop if exists('s:last_async_command') | echohl Green | echo "Command: " . s:last_async_command . " Status: success" | echohl None | endif
  autocmd User AsyncRunStop if exists('s:last_async_command') && g:asyncrun_status != 'success' | echohl Error | echo "Command: " . s:last_async_command . " Status: " . g:asyncrun_status | echohl None | endif
augroup END

" == file types
au BufReadPost *.asc set syntax=cpp
au BufReadPost *.sl set syntax=cpp
"au BufReadPost *.glsl set syntax=cpp
au BufReadPost *.hlsl set syntax=cpp

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
let g:airline_theme='base16_adwaita'
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
"let g:ctrlp_by_filename = 1
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\.git$\|\.hg$\|\.svn$|bin$|obj|data$|Debug$|Release$|RelWithDebInfo$',
"  \ 'file': '\v\.(exe|so|dll|o|d|jar|class)$',
"  \ }
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
"let g:ctrlp_lazy_update = 350

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

" Function to set up custom syntax
function! SetupCustomSyntax()
    if has('autocmd') && has('syntax')
        augroup CustomSyntaxHighlights
            autocmd!
            " Define custom syntax groups
            syn match Braces display '[{}()\[\]<>]' containedin=ALL
            syn match LogicalOperator display '\(&&\|||\|!\)' containedin=ALL
            syn keyword cppSTLtype c_auto
        augroup END
    endif
endfunction

" Function to set up highlighting based on the background
function! SetupHighlighting()
    if &background ==# 'light'
        " Light theme settings
        highlight Braces guifg=#900000 gui=bold
        highlight link Operator Normal
        highlight link LogicalOperator Normal
        highlight link OperatorHighlight Normal
        highlight link vimOperator Normal
        highlight Normal guibg=#ffffff guifg=#000000
        highlight LineNr guifg=#505050 guibg=#e0e0e0
        highlight Search guibg=#ffff00 guifg=#000000
        let g:airline_theme='solarized'
        let g:ophigh_disable = 1  " Disable operator highlighting
        let g:ophigh_color_gui = "#a01000"
    else
        " Dark theme settings
        highlight Braces guifg=#a0ff60 gui=bold
        highlight Operator guifg=#F6FF00 gui=bold
        highlight LogicalOperator guifg=#F6FF00 gui=bold
        highlight OperatorHighlight guifg=#F6FF00 gui=bold
        highlight vimOperator guifg=#F6FF00 gui=bold
        highlight Normal guibg=#080808
        highlight Search guibg=#700000 guifg=NONE
        let g:airline_theme='base16_adwaita'
        let g:ophigh_disable = 1  " Enable operator highlighting
        let g:ophigh_color_gui = "#F6FF00"
    endif

    " Refresh operator highlighting
    if exists('*OperatorHighlight#Refresh')
        call OperatorHighlight#Refresh()
    endif
endfunction

" Function to reapply custom syntax with a delay
function! ApplyCustomSyntaxLater()
    call timer_start(100, { -> SetupCustomSyntax() })
    call timer_start(150, { -> SetupHighlighting() })
endfunction

" Call SetupCustomSyntax manually with a delay to ensure it happens last
autocmd VimEnter * call ApplyCustomSyntaxLater()
" Optionally reapply syntax after colorscheme or filetype change
autocmd ColorScheme * call ApplyCustomSyntaxLater()

" Updated ToggleTheme function
function! ToggleTheme()
    echom "Current background: " . &background

    if &background ==# 'dark'
        set background=light
        colorscheme shine  " Can change this to any light theme
    else
        set background=dark
        colorscheme srcery
    endif
endfunction

" Add a command to call the function
command! ToggleTheme call ToggleTheme()

" Initial theme setup
set background=dark
colorscheme srcery

" Terminal Settings
augroup TerminalSettings
    " disable autocomplpop in terminal mode
    autocmd!
    autocmd BufEnter * if &buftype == 'terminal' | AcpDisable | setlocal bufhidden=hide | endif
    autocmd BufLeave * if &buftype == 'terminal' | AcpEnable | endif
augroup END

" ==
let g:gitgutter_async = 1
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
"let g:gitgutter_grep_command = 'grep -e'
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
" NOTE: we set the highlight down here to override others
highlight GitGutterAdd    guifg=#00aa00
highlight GitGutterChange guifg=#aaaa00
highlight GitGutterDelete guifg=#ff2222

"================================
if MySys() == "mac"
    set gfn=Iosevka:h10
    "set gfn=Menlo:h14
elseif MySys() == "windows"
    "set gfn=MS\ Gothic:h10
    "set gfn=Bitstream\ Vera\ Sans\ Mono:h9
    if has('nvim')
        " NOTE: h10 is too big for neovim-qt.
        " Better use Nvy instead
        "set gfn=Inconsolata:h7
        set gfn=Iosevka:h10.5
    else
        set gfn=Iosevka:h10.5
    endif
elseif MySys() == "linux"
    "set gfn=DejaVu\ Sans\ Mono\ 10
    "set gfn=Inconsolata\ 8
    "set gfn=DejaVu\ Sans\ Mono\ 10
    set gfn=Iosevka\ 10
endif

"" Window sizing
"" see http://vim.wikia.com/wiki/Maximize_or_set_initial_window_size
"if has("gui_running")
"    if MySys() == "windows"
"        " Use ~x on an English Windows version or ~n for French.
"        au GUIEnter * simalt ~x
"    else
"        set lines=999 columns=999
"    endif
"endif

let g:shell_fullscreen_items=0

" == Fix the swap file issue with Win 7
"if MySys() == "windows"
"    set dir=$TEMP
"endif

" DirectX
"if has("directx") && $VIM_USE_DIRECTX != '0'
"    set renderoptions=type:directx,geom:1,taamode:1
"endif

