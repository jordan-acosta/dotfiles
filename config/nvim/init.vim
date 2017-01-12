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
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" command bar
set wildmenu

" netrw
let g:netrw_preview=1
let g:netrw_liststyle=1
let g:netrw_winsize=30
let g:netrw_banner=0
let g:netrw_rmdir_cmd='rm -r'
set autochdir

" vim-plug
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Stick to defaults, don't use <tab>,
" ultisnips uses <tab>
let g:ycm_key_list_select_completion = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']

Plug 'scrooloose/syntastic'
let g:syntastic_javascript_checkers = ['eslint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'fatih/vim-go'

Plug 'pangloss/vim-javascript'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'elzr/vim-json'
call plug#end()

" Concealing
set conceallevel=1
set concealcursor=nvic

" Switch colon and semicolon
"nore ; :
"nore : ;
