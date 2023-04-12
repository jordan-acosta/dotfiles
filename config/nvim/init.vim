" Syntax highlighting
" Interface
set ruler " Show line & column number
set number
" colorscheme elflord

" Indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" TODO add custom function for resetting tab widths

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

" work-around for this bug: https://github.com/vim/vim/issues/4832
let g:netrw_sort_sequence = '[\/]\s'

" Concealing
set conceallevel=1
set concealcursor=nvic

"
" vim-plug
"

call plug#begin()

" UI
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'

" utility
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-surround'

" language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim'
Plug 'earthly/earthly.vim', { 'branch': 'main' }

call plug#end()

"
" coc
" mostly from: https://github.com/neoclide/coc.nvim#example-vim-configuration
"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" extensions
let g:coc_global_extensions = [
      \  'coc-go',
      \  'coc-tsserver',
      \  'coc-json',
      \  'coc-html',
      \  'coc-css'
      \]

" coc-go
" Weird that I have to add this. Gopls can't do this yet?
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" "
" " vim-go and other Go-related config
" " Mostly stolen from: https://hackernoon.com/my-neovim-setup-for-go-7f7b6e805876
" "
"
" " indentation
" au FileType go set noexpandtab
" au FileType go set shiftwidth=4
" au FileType go set softtabstop=4
" au FileType go set tabstop=4
"
" " special highlighting
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_types = 1
" let g:go_auto_sameids = 1
"
" " imports
" let g:go_fmt_command = "goimports"
"
" " linting
" let g:go_metalinter_autosave = 0
"
" " types and definitions
" let g:go_auto_type_info = 1
