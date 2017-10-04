# dpasca's vimfiles

## Requirements

Here's a sample .vimrc for Mac:
```vimscript
let $MYCLANGLIBPATH="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/"
let $MYVIMFILES="~/Dropbox/Settings/vimfiles"
source $MYVIMFILES/vimrc
```

...and for Windows:
```vimscript
let $MYCLANGLIBPATH="C:/Program Files (x86)/LLVM/bin"
let $MYVIMFILES="$HOME/Dropbox/Settings/vimfiles"
source $MYVIMFILES/vimrc
```

$MYCLANGLIBPATH is required to get *clang_complete* to work.

## Plugins quick overview

```vimscript
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
"" clang-driven autocomplete and jump
"Plug 'Rip-Rip/clang_complete'
" Syntax checker
"Plug 'scrooloose/syntastic'
" Find files, MRU, tags, etc.
Plug 'ctrlpvim/ctrlp.vim'
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
```

## Some custom mappings

NOTE: my \<leader\> is set to Space key

* \<leader\>o: triggers *fswitch* to change between header/source
* \<leader\>s: calls `CtrlPTag` to search for a tag interactively
* \<leader\>g: jumps to a tag under the cursor (use `:tn` and `:tp` to cycle)
* \<leader\>f: prompts GitGrep command to search for something (append ` -- *.cpp` to filter by type)
* \<leader\>wf: like \<leader\>f, but for words
* A-j/k: cycle the next and previous entry in the quick fix window
* A-c: close the quick fix window
* C-j/k: cycle autocompletion entries, instead of using C-n/p

## Extras
### My .ctags
This is what my .ctags config file looks like (that I put locally in the the root of the git repo)
```bash
--recurse=yes
--tag-relative=no
--exclude=.git
--exclude=externals
--c++-kinds=+p
--fields=+iaS
--extra=+q
```
