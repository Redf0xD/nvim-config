local mason_lspconfig = require "mason-lspconfig"
mason_lspconfig.setup({})
mason_lspconfig.setup_handlers(
  { function(server) nvim.lsp.setup(server) end }
)
nvim.event "LspSetup"
