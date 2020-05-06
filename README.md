# dpasca's vimfiles

## Requirements

Here's a sample .vimrc for Mac:
```vimscript
let $MYVIMFILES="~/Dropbox/Settings/vimfiles"
source $MYVIMFILES/vimrc
```

...and for Windows:
```vimscript
let $MYVIMFILES="$HOME/Dropbox/Settings/vimfiles"
source $MYVIMFILES/vimrc
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
### ctags support

Default ctags config file to be put either in:
`<project>/.ctags` or `<project>/ctags.d/def.ctags` in case of "Universal Ctags" (suggested)

```bash
--recurse=yes
--tag-relative=no
--exclude=.git
--exclude=externals
--c++-kinds=+p
--fields=+iaS
--extra=+q
```
