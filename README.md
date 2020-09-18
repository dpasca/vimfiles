# dpasca's vimfiles

## Requirements

Here's a sample `.vimrc` or `~/.config/nvim/init.vim` for Mac/Linux:
```vimscript
let $MYVIMFILES="~/vimfiles_dav"
source $MYVIMFILES/vimrc
```
...and for Windows:

```vimscript
let $MYVIMFILES="$HOME/vimfiles_dav"
source $MYVIMFILES/vimrc
```

These assume that this repo was cloned in `~/vimfiles_dav` as an example.

## Latest gvim Windows builds

* https://tuxproject.de/projects/vim/x64/

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
`<project>/.ctags` or `<project>/ctags.d/def.ctags` in case of [Universal Ctags](https://github.com/universal-ctags/ctags) (suggested)

```bash
--recurse=yes
--tag-relative=no
--exclude=.git
--exclude=externals
--c++-kinds=+p
--fields=+iaS
--extra=+q
```

### tmux configuration

Launch with `tmux -2` for a betetr chance to have full-color experience in vim/neovim.

My `~.tmux.conf`:

```tmux
# mouse support
set -g status-keys vi
setw -g mode-keys vi

set -s escape-time 0

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
```
