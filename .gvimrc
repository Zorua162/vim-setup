"MY customisations
"
"
set noeb vb t_vb=

"Remove all the annoying gvim bars
set guioptions -=m "menu bar
set guioptions -=T "toolbar
set guioptions -=r "scrollbar
set guioptions -=i "Attempt to remove vim icon from taskbar
set guioptions -=e "tabs are in window rather than gui
set guioptions -=L "no scroll bar when vertically split

"source $VIMRUNTIME/mswin.vim
"behave mswin

"start maximised

"This is in default vimrc, however wasnt here for some reason?
if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  endif 

