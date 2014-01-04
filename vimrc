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
map <C-e> :NERDTreeToggle<CR>
Bundle 'scrooloose/syntastic'
Bundle 'myusuf3/numbers.vim'
set number "required by numbers and vim 7.4
Bundle 'kien/ctrlp.vim'
Bundle 'Shougo/neocomplcache.vim'
let g:neocomplcache_enable_at_startup = 1
Bundle 'Lokaltog/vim-easymotion'
Bundle 'bufexplorer.zip'
Bundle 'flazz/vim-colorschemes'
Bundle 'Townk/vim-autoclose'

" and execute vim +BundleInstall +qall

filetype plugin indent on     " required!

let mapleader = ","

" See https://github.com/sigurdga/gnome-terminal-colors-solarized
set background=dark
set t_Co=16
color solarized

set mouse=a

set tabstop=4 shiftwidth=4 expandtab

set hlsearch
highlight ExtraWhitespace ctermbg=darkred
match ExtraWhitespace /\s\+$/
