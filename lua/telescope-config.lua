local builtin = require('telescope.builtin')

vim.keymap.set('n', 'ff', builtin.git_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})

vim.keymap.set('n', 'gr', builtin.lsp_references, {})
vim.keymap.set('n', 'gs', builtin.lsp_dynamic_workspace_symbols, {})
