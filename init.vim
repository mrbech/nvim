call plug#begin(stdpath('data') . '/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'overcache/NeoSolarized'
Plug 'ervandew/supertab'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp' 
Plug 'reasonml-editor/vim-reason-plus'
Plug 'mrbech/nvim-lsplocalconfig'
Plug 'easymotion/vim-easymotion'

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

" clear hover and sync syntax via space
noremap <silent> <Space> :silent noh <Bar>echo<cr>:syn sync fromstart<cr>

" Format
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set smartindent

" LSP
lua require('lsp')

" Flutter
autocmd FileType dart autocmd BufWritePost * silent execute '!kill -USR1 $(pgrep -f "[f]lutter_tools.snapshot run")'
autocmd FileType dart noremap <Leader>r <cmd>silent execute '!kill -USR2 $(pgrep -f "[f]lutter_tools.snapshot run")'<CR>
