"version 3.0.0
"Last Updated 2020/08/09
"==================================================
"Simple changes to Vim
"==================================================
"Enables vim features such as reg shifting
set nocompatible

"Set the encoding
set encoding=utf-8

"Show line numbers
set number

"Syntax highlighting
syntax on

"Font and size
set guifont=Consolas:h10

"Change tab setup
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" make backspace work like most other programs
set backspace=2 

"Fast spelling mistake fixer uper
"set spell
set spelllang=en_gb
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"mouse to more windows like mode
set mouse=a

"always show status bar
set ls=2

"Set some lines visible above and below cursor
set scrolloff=10

"Do case insensitive searching
set ignorecase

"set a line at 80
set colorcolumn=80

"Dont wrap text if it goes out of the window
set nowrap

" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" disabled by default because preview makes the window flicker
set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

"Required for plugins
filetype plugin indent on

"look for search term in real time and highlight them
set incsearch
set hlsearch

" better backup, swap and undos storage for vim (nvim has nice ones by
" default)
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" create needed directories if they don't exist
"
"

set splitbelow
set splitright

if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

"removes ugly characters on vertical splits
set fillchars+=vert:\ 

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
"set shell=/bin/bash 

"==================================================
"Auto commands
"==================================================
"
if has("autocmd")
    "Reset vim back to where last session was left off
    au BufReadPost * if line("'\"") > 1 && line("'\"") 
                  \<= line("$") | exe "normal! g'\"" | 


    " clear empty spaces at the end of lines on save of python files
    autocmd BufWritePre *.py :%s/\s\+$//e

    autocmd BufWritePost * :mks! ~/.vim/sessions/last_session.vim
endif



"==================================================
"Custom key remapping
"==================================================

"Escape terminal mode by pressing esc
tnoremap <Esc> <C-\><C-n>

"vimrc editing
" Edit vimr configuration file
let mapleader=","
"nnoremap <Leader>ve :e ~/.vim/.vimrc<cr>
nnoremap <Leader>ve :e ~/Dropbox/vim/.vimrc<cr>
" " Reload vimr configuration file
"nnoremap <Leader>vr :source ~/.vim/.vimrc<cr> 
nnoremap <Leader>vr :source ~/Dropbox/vim/.vimrc<cr> 

"Stolen from https://github.com/gillescastel/inkscape-figures 
inoremap <C-h> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-h> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>



source ~/Dropbox/vim/simplesessions.vimrc

source ~/Dropbox/vim/functions.vimrc
"==================================================
"Installing vim plug on first run
"==================================================
"
"Stolen from vimrc by http://vim.fisadev.com
let using_neovim = has('nvim')
let using_vim = !using_neovim

" ============================================================================
" Vim-plug initialization
" Avoid modifying this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
if using_neovim
    let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    echo "WARNING: ENSURE CURL IS INSTALLED OTHERWISE THIS WONT WORK"
    if has("win32")
        "windows download here
        if using_neovim
            cd ~
            silent !mkdir -p ./nvim/autoload
            silent !curl -fLo ./nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        else
            cd ~
            silent !mkdir -p ./.vim/autoload
            !curl -fLo ./.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        endif
        let vim_plug_just_installed = 1
    else
        if has("unix")
            if using_neovim
                silent !mkdir -p ~/.config/nvim/autoload
                silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            else
                silent !mkdir -p ~/.vim/autoload
                !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            endif
            let vim_plug_just_installed = 1
        endif
    endif
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

"==================================================
"Installing plugins
"==================================================

"Install plugins
call plug#begin("~/.vim/plugged")
"Compile latex and display in pdf viewer
Plug 'lervag/vimtex'
"Colour scheme for vim/nvim
Plug 'joshdick/onedark.vim'
"Allows use of custom snippets
Plug 'sirver/ultisnips'
"Starting page
Plug 'mhinz/vim-startify'


""Adds a suggestion box
"Plug 'Shougo/deoplete.nvim'
""deoplete requirements
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'
""Code linter
"Plug 'neomake/neomake'
"" Automatically close parenthesis, etc
"Plug 'Townk/vim-autoclose'
""Python autocompletion
"Plug 'davidhalter/jedi-vim'
"" Surround (use cs to change parenthesis)
"Plug 'tpope/vim-surround'
call plug#end()

"==================================================
"Configuring plugins
"==================================================

"VimTex ------------------------------

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
"let g:vimtex_quickfix_mode=0


"One Dark ------------------------------

colorscheme onedark


"UltiSnips ------------------------------

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


" Neomake ------------------------------
"
"" Run linter on write
"autocmd! BufWritePost * Neomake
"
"" Check code as python3 by default
"let g:neomake_python_python_maker = neomake#makers#ft#python#python()
"let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
"let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
"let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'
"
"" Disable error messages inside the buffer, next to the problematic line
"let g:neomake_virtualtext_current_error = 0
"
"
"" Deoplete -----------------------------
"
"" Use deoplete.
"let g:deoplete#enable_at_startup = 1
"call deoplete#custom#option({
"\   'ignore_case': v:true,
"\   'smart_case': v:true,
"\})
"" complete with words from any opened file
"let g:context_filetype#same_filetypes = {}
"let g:context_filetype#same_filetypes._ = '_'
"
"" Jedi-vim ------------------------------
"
"" Disable autocompletion (using deoplete instead)
"let g:jedi#completions_enabled = 0
"
"" All these mappings work only for python code:
"" Go to definition
"let g:jedi#goto_command = ',d'
"" Find ocurrences
"let g:jedi#usages_command = ',o'
"" Find assignments
"let g:jedi#goto_assignments_command = ',a'
"" Go to definition in new tab
"nmap ,D :tab split<CR>:call jedi#goto()<CR>

