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

*clang_complete* requires *clang* to be installed in the system.
For Windows I have and hardcoded *vimrc* setting that expects `libclang.dll` in `$HOME\Dropbox\Settings\` (I should move that to `vimfiles\` itself).

## The plugins

* **Vundle**: manages plugins automatically
* **AutoComplPop**: autocomplete on-the-fly, no need to press ctrl-n/p
* **AutoTag**: update tags (needs pre-existing `tags` file) *tags* still work better and faster than *clang_complete* for me
* **vim-colorscheme-switcher**: quickly cycle color scheme with F8
* **GitGrep**: fast grep based on git 
* **vim-qargs**: useful for mass replace after a grep. Example `Qdo %s/src/repl`
* **clang_complete**: Intellisense-like C++ autocompletion 
* **ctrlp**: quickly search for file names and recent files (do ctrl-b to cycle). It finds and uses the .git root as a reference
* **NERDTree**: side bar to browse and open files and dirs
* **fswitch**: quickly switch between *.cpp* and *.h* (I mapped it to \<leader\>o)
* **DirDiff**: compare dirs recursively with `DirDiff dir1/ dir2/` (has windowing problems when vim-fugitive is installed)
* **vim-fugitive**: Gitting IDE-style (:Gstatus, :Gcommit, etc.)

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
