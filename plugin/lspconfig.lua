--vim.lsp.set_log_level("debug")

local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function bufmap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- Muestra información sobre símbolo debajo del cursor
  bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

  -- Saltar a definición
  bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)

  -- Saltar a declaración
  bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)

  -- Mostrar implementaciones
  bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)

  -- Saltar a definición de tipo
  bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)

  -- Listar referencias
  bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)

  -- Mostrar argumentos de función
  bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

  -- Renombrar símbolo
  bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)

  -- Listar "code actions" disponibles en la posición del cursor
  bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

  -- Mostrar diagnósticos de la línea actual
  bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)

  -- Saltar al diagnóstico anterior
  bufmap('n', '<Left>', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)

  -- Saltar al siguiente diagnóstico
  bufmap('n', '<Right>', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  -- formatting
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.format() end
    })
  end
end

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

nvim_lsp.jedi_language_server.setup {
}

nvim_lsp.cssmodules_ls.setup {
}
nvim_lsp.cssls.setup {
}
nvim_lsp.emmet_ls.setup {
}
nvim_lsp.marksman.setup {
}
nvim_lsp.lemminx.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
nvim_lsp.solc.setup {
}
nvim_lsp.eslint.setup {}

nvim_lsp.tsserver.setup {
}


nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim', 'use' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
}

nvim_lsp.tailwindcss.setup {}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 2, prefix = "●" },
  severity_sort = true,
}
)
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)
-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
