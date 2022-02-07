call plug#begin(stdpath('data') . '/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'overcache/NeoSolarized'
Plug 'ervandew/supertab'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp' 
Plug 'reasonml-editor/vim-reason-plus'
Plug 'mrbech/nvim-lsplocalconfig'

call plug#end()

" UI
let g:neosolarized_contrast = "high"
colorscheme NeoSolarized
set number
set wildmode=longest,list,full
set wildmenu
set showmatch

" Keybindings
map tn :tabnext <RETURN>
map tb :tabprevious <RETURN>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

map <C-c> :noh <RETURN>
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smartindent

" Haskell
autocmd Filetype haskell setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Lua
autocmd Filetype haskell setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Dart
autocmd Filetype dart setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" LSP

lua require('lsp')
