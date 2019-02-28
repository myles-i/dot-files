set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlp.vim'
" Set no max file limit
let g:ctrlp_max_files = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_depth=40 
" " Ignore these directories
set wildignore+=*/_prometheus/**
set wildignore+=*/legacy_sysg7x/**

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" General vim settings:
:set tabstop=4
:set shiftwidth=4
:set expandtab

" make paste not assume comment
:set paste

" Make search more sane
set ignorecase " case insensitive search
set smartcase " If there are uppercase letters, become case-sensitive.
set incsearch " live incremental searching
set showmatch " live match highlighting
set hlsearch " highlight matches
set gdefault " use the `g` flag by default.

" So we don't have to reach for escape to leave insert mode.
inoremap jf <esc>

" show line numbers
set number
