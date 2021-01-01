"==================================================
"Simple session handler
"==================================================
"My simple session setup
fun SessionCompleteFileName(A,L,P)
    return map(globpath(s:sessionpath, a:A.'*', 0, 1), s:subpath_map)
endfun

let s:sessionpath="~/.vim/sessions/"
let s:subpath_map = { k,v -> fnamemodify(v,':p')[(s:leading_len):] }
let s:leading_len = len(s:sessionpath) + 9

command! -nargs=1 -complete=customlist,SessionCompleteFileName
\ Sesh source ~/.vim/sessions/<args> 

command! -nargs=1 -complete=customlist,SessionCompleteFileName
\ NewSesh mks ~/.vim/sessions/<args>

command! -nargs=1 -complete=customlist,SessionCompleteFileName
\ MkSesh mks ~/.vim/sessions/<args>

command! -nargs=1 -complete=customlist,SessionCompleteFileName
\ OwSesh mks! ~/.vim/sessions/<args> 


command! -nargs=1 -complete=customlist,SessionCompleteFileName
\ RmSesh !rm ~/.vim/sessions/<args>

command! -nargs=1 -complete=customlist,SessionCompleteFileName
\ MvSesh !mv v:this_session ~/.vim/sessions/<args> 

command! -nargs=1 NewSeshFolder !mkdir ~/.vim/sessions/<args>

command! Ssesh exe "mks! " . v:this_session

command! SS exe "mks! " . v:this_session

command! CurrentSesh echomsg "The current session is".v:this_session

command! LastSesh source ~.vim/sessions/lastsession.vim

command! LS source ~.vim/sessions/lastsession.vim
function SessionSaveAndQuitFunct()
    :SS
    :qa
endfunction
command! SQ exec SessionSaveAndQuitFunct()

let helpinfo = "Session based aliases commands: \n Sesh - openSession"
let helpinfo .="\nNewSesh - create a new session with the current layout"
let helpinfo .="\nMkSesh - alias for NewSesh"
let helpinfo .="\nOwSesh - overwrite a session that has already been created"
let helpinfo .="\nRmSesh - remove a session"
let helpinfo .="\nMvSesh- rename a session"
let helpinfo .="\nSsesh - save the current session"
let helpinfo .="\nSS - alias for Ssesh"
let helpinfo .="\nNewSeshFolder - Create a new session folder"
command! SeshHelp echo helpinfo 

"nnoremap ss SS

"remeber which session was last open in .vim

"autocmd * .vimLeavePre call writefile([v:this_session],'~/vim/sessions/lastsession.seshdat')
autocmd * .vimLeavePre mks! ~.vim/sessions/lastsession.vim 

