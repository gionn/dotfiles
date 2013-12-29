set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My bundles here:
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'myusuf3/numbers.vim'
set number "required by numbers and vim 7.4
Bundle 'kien/ctrlp.vim'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'bufexplorer.zip'
Bundle 'flazz/vim-colorschemes'

" and execute vim +BundleInstall +qall

filetype plugin indent on     " required!

let mapleader = ","

" See https://github.com/sigurdga/gnome-terminal-colors-solarized
set background=dark
set t_Co=16
color solarized
