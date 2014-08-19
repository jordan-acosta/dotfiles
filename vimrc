" Syntax highlighting
syntax on
color elflord

" Interface
set ruler " Show line & column number
set number
set hlsearch

" Indentation
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Code Folding
set foldmethod=indent " fold based on indent
set nofoldenable " don't fold by default
set foldlevel=1 " only close/open one foldlevel at a time
au BufWinLeave * silent! mkview " save view when closing buffer
au BufWinEnter * silent! loadview " load view when opening buffer

" Up/down keys move up/down through wrapped lines.
nnoremap <Down> gj
nnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
vnoremap <Down> gj
vnoremap <Up> gk

" Omni completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Other
set history=1000

" golang
filetype off
filetype plugin indent off
set runtimepath+=/usr/local/Cellar/go/1.2.2/libexec/misc/vim
filetype plugin indent on
syntax on

" Switch colon and semicolon
"nore ; :
"nore : ;

" Enable mouse support
"set mouse=a

" Vundle
"set nocompatible
"filetype off
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()
"Bundle 'gmarik/vundle'

" Github Vundle bundles
"Bundle 'Lokaltog/vim-powerline'

" End Vundle
"filetype plugin indent on
