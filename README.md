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

## The plugins

* **Vundle**: manages plugins automatically
* **AutoComplPop**: autocomplete on-the-fly, no need to press ctrl-n/p
* **AutoTag**: update tags (needs pre-existing `tags` file) *tags* still work better and faster than *clang_complete* for me
* **vim-colorscheme-switcher**: quickly cycle color scheme with F8
* **vim-qargs**: useful for mass replace after a grep. Example `Qdo %s/src/repl`
* **git-grep-vim**: fast grep based on git 
* **clang_complete**: Intellisense-like C++ autocompletion 
* **ctrlp**: quickly search for file names and recent files (do ctrl-b to cycle). It finds and uses the .git root as a reference
* **nerdtree**: side bar to browse and open files and dirs
* **vim-fswitch**: quickly switch between *.cpp* and *.h* (I mapped it to \<leader\>o)
* **vim-cpp-enhanced-highlight**: improved syntax highlight for C++
* **vim-operator-highlight**: operators highlight
* **DirDiff**: compare dirs recursively with `DirDiff dir1/ dir2/` (has windowing problems when vim-fugitive is installed)
* **vim-fugitive**: Gitting IDE-style (:Gstatus, :Gcommit, etc.)
* **vim-gutter**: gutter with git changes. Jump with ]c [c, stage and revert with <leader>hs / hr
* **hexmode**: simplified hex editing

## Some custom mappings

NOTE: my \<leader\> is set to `,` (comma).

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
--tag-relative=yes
--exclude=.git
--exclude=externals
--c++-kinds=+p
--fields=+iaS
--extra=+q
```
