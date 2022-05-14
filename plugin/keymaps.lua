-- Mapping helper
local mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true, expr = false })
end

-- Expressive Mapping helper
local expressive_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, { silent = true, expr = true })
end

-- Default Mapping helper
local plug_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {})
end

-- Define Mapleader
vim.g.mapleader = ' '

-- Open the file init.vim
mapper('n','<leader>e', ':Dashboard<CR>')

-- Save
mapper('n', '<leader>w', ':w<CR>')

--Exit
mapper('n', '<leader>q', ':q<CR>')

--Force Exit
mapper('n', '<leader>qq', ':qa!<CR>')

--Buffers Delete
-- mapper('n', '<leader>b', ':bdelete<CR>')

-- Duplitcate Line
mapper('n', 'tt', ':t.<CR>')

-- use ESC to turn off search highlighting
mapper('n', '<Esc>', ':noh<CR>')

--Fast Scroll
-- plug_mapper('n', '<C-j>', '10<C-e>')
-- plug_mapper('n', '<C-k>', '10<C-y>')

-- Get out of the Terminal
mapper('t', '<Esc>', '<C-\\><C-n>')

-- Resize with arrows
mapper('n', '<C-Up>', ':resize -2<CR>')
mapper('n', '<C-Down>', ':resize +2<CR>')
mapper('n', '<C-Left>', ':vertical resize -2<CR>')
mapper('n', '<C-Right>', ':vertical resize +2<CR>')

-- Copy to OS clipboard.
mapper('n', '<Leader>y', '"+y')
mapper('v', '<Leader>y', '"+y')
mapper('n', '<Leader>yy', '"+yy')

-- Paste from OS clipboard
mapper('n', '<Leader>p', '"+p')
mapper('n', '<Leader>P', '"+P')
mapper('v', '<Leader>p', '"+p')
mapper('v', '<Leader>P', '"+P"`"`"')

mapper('n', 'J', 'mzJ`z')

-- Open Terminal
mapper('n', '<C-t>', ':call OpenTerminal()<CR>')


-- Plugins Mappings ↓

-- Telescope
mapper('n', '<C-F>', ':Telescope live_grep<CR>')
mapper('n', '<C-P>', ':Telescope find_files<CR>')
mapper('n', '<C-R>', ':Telescope projects<CR>')

-- Tree
mapper('n', '<leader>nt', ':NvimTreeToggle<CR>')

-- Hop.nvim
mapper('n', '<Leader>f', ':HopWord<CR>')
mapper('n', '<Leader>o', ':HopPattern<CR>')

-- Switch Theme
mapper('n', '<leader>mm', [[<Cmd>lua require('material.functions').toggle_style()<CR>]])

-- Coc.nvim
mapper('n', '<F12>', ':CocCommand terminal.Toggle<CR>')
-- mapper('n', '<F3>', ':Format<CR>')

plug_mapper('n', '<leader>rn', '<Plug>(coc-rename)')

plug_mapper('n', 'gd', '<Plug>(coc-definition)')
plug_mapper('n', 'gr', '<Plug>(coc-references)')

plug_mapper('n', '<leader>ca', '<Plug>(coc-codeaction)')
plug_mapper('n', '<leader>ga', '<Plug>(coc-codeaction-cursor)')
plug_mapper('x', '<leader>ga', '<Plug>(coc-codeaction-selected)')
plug_mapper('n', '<leader>qf', '<Plug>(coc-fix-current)')

plug_mapper('n', '<Right>', '<Plug>(coc-diagnostic-prev)')
plug_mapper('n', '<Left>', '<Plug>(coc-diagnostic-next)')

expressive_mapper('i', '<C-space>', 'coc#refresh()')
-- Debugger Config

mapper('n', '<leader>ds', ':lua require"dap".continue()<CR>') -- Start debugging
mapper('n', '<leader>db', ':lua require"dap".toggle_breakpoint()<CR>') -- Toggle breakpoint
mapper('n', '<leader>dt', ':lua require"dap".step_over()<CR>') -- Step over
mapper('n', '<leader>di', ':lua require"dap".step_into()<CR>') -- Step into
mapper('n', '<leader>do', ':lua require"dap".step_out()<CR>') -- Step out
mapper('n', '<leader>dr', ':lua require"dap".repl.toggle()<CR>') -- Toggle REPL
mapper('n', '<leader>dc', ':lua require"dap".terminate()<CR>') -- End the debugging session

-- Bufferline Config
mapper('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>')
mapper('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>')
mapper('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>')
mapper('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>')
mapper('n', '<leader>5', ':BufferLineGoToBuffer 5<CR>')
mapper('n', '<leader>6', ':BufferLineGoToBuffer 6<CR>')
mapper('n', '<leader>7', ':BufferLineGoToBuffer 7<CR>')
mapper('n', '<leader>8', ':BufferLineGoToBuffer 8<CR>')
mapper('n', '<leader>9', ':BufferLineGoToBuffer 9<CR>')

mapper('n', '<M-.>', ':BufferLineCycleNext<CR>')
mapper('n', '<M-,>', ':BufferLineCyclePrev<CR>')
mapper('n', '<M-c>', ':BufferLinePickClose <CR>')
mapper('n', '<leader>b', ':bdelete! <CR>')


-- TODO: Pass to Lua
vim.cmd([[
nnoremap <silent> <M-k>    :<C-U>exec "exec 'norm m`' \| move -" . (1+v:count1)<CR>``
nnoremap <silent> <M-j>  :<C-U>exec "exec 'norm m`' \| move +" . (0+v:count1)<CR>``

vnoremap <silent> <M-k>    :<C-U>exec "'<,'>move '<-" . (1+v:count1)<CR>gv
vnoremap <silent> <M-j>  :<C-U>exec "'<,'>move '>+" . (0+v:count1)<CR>gv

nnoremap <silent> <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
]])

