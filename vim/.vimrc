call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
call plug#end()

set clipboard=unnamedplus
set ignorecase
set scrolloff=30
set history=200
set number
set incsearch
set hlsearch
inoremap  <nowait> jk  <Esc>`^
let mapleader=','

" set the split operation"
nnoremap <Leader>\ <C-W>v
nnoremap <Leader>- <C-W>s
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-,> <C-W><
nnoremap <C-.> <C-W>>
nnoremap <C-=> <C-W>+
nnoremap <C--> <C-W>-
nnoremap <C-w> :wq<cr>



" ================================================================================================
" ================================================================================================
" plugin set"
" ================================================================================================
" ================================================================================================
" easymotion
map <leader>s <Plug>(easymotion-s2)

" NERDTree
nnoremap <leader>g :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFind<cr>

" multiple-cursors
" https://stackoverflow.com/questions/55202799/ideavim-multi-cursor-usage
" Remap multiple-cursors shortcuts to match terryma/vim-multiple-cursors
nmap <C-n> <Plug>NextWholeOccurrence
xmap <C-n> <Plug>NextWholeOccurrence
nmap g<C-n> <Plug>NextOccurrence
xmap g<C-n> <Plug>NextOccurrence
nmap <C-x> <Plug>SkipOccurrence
xmap <C-x> <Plug>SkipOccurrence
nmap <C-p> <Plug>RemoveOccurrence
xmap <C-p> <Plug>RemoveOccurrence
" Note that the default <A-n> and g<A-n> shortcuts don't work on Mac due to dead keys.
" <A-n> is used to enter accented text e.g. ñ
nmap <S-C-n> <Plug>AllWholeOccurrences
xmap <S-C-n> <Plug>AllWholeOccurrences
nmap g<S-C-n> <Plug>AllOccurrences
xmap g<S-C-n> <Plug>AllOccurrences
