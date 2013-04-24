# dpasca's vimfiles

## Overview

I work mostly in C++ and my ideal setup is *Visual Studio* with *Visual Assist X* and *ViEmu*.
<br>This setup is an attempt to get close to that. Not there yet, but that's the goal.
<br>My \<leader\> is set to `,` (comma).

## Requirements

*clang_complete* requires *clang* to be installed in the system.
For Windows I have and hardcoded *vimrc* setting that expects `libclang.dll` in `$HOME\Dropbox\Settings\` (I should move that to `vimfiles\` itself).

## The plugins

Using *pathogen* to have all plugins in individual dirs (git submodules actually) under `bundle/`

* **AutoComplPop**: autocomplete on-the-fly, no need to press ctrl-n/p
* **EasyGrep**: simply type `Grep <search text>` or \<leader\>vv to search recursively (instead of `vim /yoyo/ **/*.cpp **/*.h` etc.)
* **ack**: similar to *EasyGrep*, but potentially faster (requires *ack* installed in the system)
* **clang_complete**: Intellisense-like C++ autocompletion (and declaration jump with ctrl-])
* **ctrlp**: ctrl-p to quickly search for file names, and recent files (do ctrl-b afterwards)
* **fswitch**: quickly switch between *.cpp* and *.h* (I mapped it to \<leader\>o)
* **nerdtree**: side bar to browse and open files and dirs
