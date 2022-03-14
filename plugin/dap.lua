function Dap()
  -- Load Plugins

  vim.cmd([[packadd dap]])
  vim.cmd([[packadd teledap]])
  vim.cmd([[packadd dapy]])
  vim.cmd([[packadd dapui]])
end

local dap = require('dap')

local install_path = vim.fn.stdpath("data") .. "\\dapinstall\\"

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/Debugger/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}


local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

map('n', '<leader>ds', ':lua require"dap".continue()<CR>', opts) -- Start debugging
map('n', '<leader>db', ':lua require"dap".toggle_breakpoint()<CR>', opts) -- Toggle breakpoint
map('n', '<leader>dt', ':lua require"dap".step_over()<CR>', opts) -- Step over
map('n', '<leader>di', ':lua require"dap".step_into()<CR>', opts) -- Step into
map('n', '<leader>do', ':lua require"dap".step_out()<CR>', opts) -- Step out
map('n', '<leader>dr', ':lua require"dap".repl.toggle()<CR>', opts) -- Toggle REPL
map('n', '<leader>dc', ':lua require"dap".terminate()<CR>', opts) -- End the debugging session

