local nvim_lsp = require('lspconfig')
local cmp = require 'cmp'
local luasnip = require('luasnip')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_init = function(client, initialization_result)
  if client.server_capabilities then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<Leader>t', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<Leader>T', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  if client.server_capabilities.documentFormattingProvider 
     or client.server_capabilities.documentRangeFormattingProvider
     or client.server_capabilities.documentOnTypeFormattingProvider then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
  end

  local code_lens = client.config.code_lens or client.config.code_lens == nil
  if code_lens and client.server_capabilities.codeLensProvider then
    vim.cmd("highlight default link LspCodeLens Todo")
    vim.lsp.codelens.refresh()
    buf_set_keymap('n', 'gl', '<cmd>lua vim.lsp.codelens.run()<CR>', opts)
    vim.cmd("autocmd BufWritePre,BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()")
  end
end

local config = {
  capabilities = capabilities,
  on_init = on_init,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}
local default_configs = {
  hls = {},
  dartls = {},
  ts_ls = {},
  rust_analyzer = {},
  clangd = {},
  fsautocomplete = {
    code_lens = false,
  },
}
require'lsplocalconfig'(config, default_configs)

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
  },
}
