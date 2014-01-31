" be iMproved!
set nocompatible

" Vundle setup
filetype off                  " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Vundle plugin list:

Bundle 'tpope/vim-fugitive'

Bundle 'scrooloose/nerdtree'
map <C-e> :NERDTreeToggle<CR>

Bundle 'scrooloose/syntastic'

Bundle 'myusuf3/numbers.vim'
set number "required for vim 7.4
set regexpengine=1 "mitigate vim 7.4 weird performance regression"

Bundle 'kien/ctrlp.vim'

Bundle 'Shougo/neocomplcache.vim'
let g:neocomplcache_enable_at_startup = 1

Bundle 'Lokaltog/vim-easymotion'

Bundle 'bufexplorer.zip'

Bundle 'flazz/vim-colorschemes'

Bundle 'Townk/vim-autoclose'

" End Vundle setup - execute vim +BundleInstall +qall

filetype plugin indent on

" Use an easy to reach key as leader
let mapleader = ","

" COLORS!
" See https://github.com/sigurdga/gnome-terminal-colors-solarized
set background=dark
set t_Co=16
color solarized

" Add mouse support
set mouse=a

" Configure spaces and avoid tabs
set tabstop=4 shiftwidth=4 expandtab

" Highlight searches
set hlsearch
" Show extra white spaces in red!
highlight ExtraWhitespace ctermbg=darkred
match ExtraWhitespace /\s\+$/
