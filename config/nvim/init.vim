" Lines
set ruler
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

" command bar
set wildmenu

" netrw
let g:netrw_preview=1
let g:netrw_liststyle=4
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
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

" utility
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-surround'

" language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim'
Plug 'earthly/earthly.vim', { 'branch': 'main' }
Plug 'elixir-editors/vim-elixir'

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
nmap <silent> gs  :<C-u>CocList -I symbols<cr>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" extensions
let g:coc_global_extensions = [
      \  'coc-go',
      \  'coc-tsserver',
      \  'coc-prettier',
      \  'coc-json',
      \  'coc-html'
      "\  'coc-css'
      \]

" coc-go
" Weird that I have to add this. Gopls can't do this yet?
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

"
" telescope
"

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
