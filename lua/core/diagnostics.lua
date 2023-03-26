local signs = {
  { name = "DiagnosticSignError",    text = nvim.get_icon "DiagnosticError" },
  { name = "DiagnosticSignWarn",     text = nvim.get_icon "DiagnosticWarn" },
  { name = "DiagnosticSignHint",     text = nvim.get_icon "DiagnosticHint" },
  { name = "DiagnosticSignInfo",     text = nvim.get_icon "DiagnosticInfo" },
  { name = "DiagnosticSignError",    text = nvim.get_icon "DiagnosticError" },
  { name = "DapStopped",             text = nvim.get_icon "DapStopped",             texthl = "DiagnosticWarn" },
  { name = "DapBreakpoint",          text = nvim.get_icon "DapBreakpoint",          texthl = "DiagnosticInfo" },
  { name = "DapBreakpointRejected",  text = nvim.get_icon "DapBreakpointRejected",  texthl = "DiagnosticError" },
  { name = "DapBreakpointCondition", text = nvim.get_icon "DapBreakpointCondition", texthl = "DiagnosticInfo" },
  { name = "DapLogPoint",            text = nvim.get_icon "DapLogPoint",            texthl = "DiagnosticInfo" },
}

for _, sign in ipairs(signs) do
  if not sign.texthl then sign.texthl = sign.name end
  vim.fn.sign_define(sign.name, sign)
end

nvim.lsp.diagnostics = {
  off = {
    underline = false,
    virtual_text = false,
    signs = false,
    update_in_insert = false,
  },
  on = {
    virtual_text = false,
    signs = { active = signs },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focused = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  },
}

vim.diagnostic.config(nvim.lsp.diagnostics[vim.g.diagnostics_enabled and "on" or "off"])
