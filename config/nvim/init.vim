" Syntax highlighting
color elflord

" Interface
set ruler " Show line & column number
set number

" Indentation
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
"filetype plugin on
"set omnifunc=syntaxcomplete#Complete

" command bar
set wildmenu

" netrw
let g:netrw_preview=1
let g:netrw_liststyle=1
let g:netrw_winsize=30
let g:netrw_banner=0
let g:netrw_rmdir_cmd='rm -r'
let g:netrw_keepdir= 0
set autochdir

" vim-plug
call plug#begin()

" UI

Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" utility

Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-surround'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"Plug 'neomake/neomake'

" language support

Plug 'pangloss/vim-javascript'
Plug 'carlitux/deoplete-ternjs', { 'do': 'yarn global add tern' }

Plug 'elzr/vim-json'

Plug 'fatih/vim-go'
call plug#end()

" deoplete
let g:deoplete#enable_at_startup = 1

" Concealing
set conceallevel=1
set concealcursor=nvic
