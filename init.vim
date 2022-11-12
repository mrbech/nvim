call plug#begin(stdpath('data') . '/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'ervandew/supertab'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp' 
Plug 'mrbech/nvim-lsplocalconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'ggandor/leap.nvim'
Plug 'psiska/telescope-hoogle.nvim'

call plug#end()

" UI
set number
set wildmode=longest,list,full
set wildmenu
set showmatch
set mouse=""

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

" Telescope
lua require('telescope-config')

" Leap
lua require('leap').set_default_keymaps()


" sigpr development
noremap <Leader>r <cmd>silent execute '!sigpr restart'<CR>
autocmd BufWritePost * silent execute '!sigpr restart' 

" Flutter
autocmd FileType dart autocmd BufWritePost * silent execute '!kill -USR1 $(pgrep -f "[f]lutter_tools.snapshot run")'
autocmd FileType dart noremap <Leader>r <cmd>silent execute '!kill -USR2 $(pgrep -f "[f]lutter_tools.snapshot run")'<CR>
