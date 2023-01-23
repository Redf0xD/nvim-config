-- Mapping helper
local mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true, expr = false })
end

-- Expressive Mapping helper
local expressive_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, { silent = true, noremap = true, expr = true, replace_keycodes = false })
end

-- Default Mapping helper
local plug_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {})
end

-- Define Mapleader
vim.g.mapleader = ' '

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
mapper('n', '<C-j>', '10<C-e>')
mapper('n', '<C-k>', '10<C-y>')

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

-- Plugins Mappings ↓

-- Telescope
mapper('n', '<C-F>', ':Telescope live_grep<CR>')
mapper('n', '<C-P>', ':Telescope find_files<CR>')
mapper('n', '<C-W>', ':Telescope projects<CR>')

-- Tree
mapper('n', '<leader>nt', ':NvimTreeToggle<CR>')

-- Hop.nvim
mapper('n', '<Leader>f', ':HopWord<CR>')
mapper('n', '<Leader>o', ':HopPattern<CR>')

-- COC
expressive_mapper("i", "<TAB>",
  'coc#pum#visible() ? coc#pum#confirm() : v:lua.check_back_space() ? "<TAB>" : coc#refresh()')

-- Use <c-space> to trigger completion.
expressive_mapper("i", "<c-space>", "coc#refresh()")

-- Use `Left` and `Right` to navigate diagnostics
mapper("n", "<Left>", "<Plug>(coc-diagnostic-prev)")
mapper("n", "<Right>", "<Plug>(coc-diagnostic-next)")

mapper('n', '<F2>', ':CocCommand<CR>')
mapper('n', 'qf', "<Plug>(coc-fix-current)")

-- open a terminal
mapper('n', '<F12>', ':CocCommand terminal.Toggle<CR>')

-- Formatting selected code.
mapper("x", "<F3>", ":Format<CR>")
mapper("n", "<F3>", ":Format<CR>")

plug_mapper('n', '<leader>rn', '<Plug>(coc-rename)')

-- GoTo code navigation.
plug_mapper('n', 'gd', '<Plug>(coc-definition)')
plug_mapper('n', 'gr', '<Plug>(coc-references)')

-- Remap keys for applying codeAction to the current buffer.
plug_mapper('n', '<leader>ca', '<Plug>(coc-codeaction)')
plug_mapper('n', '<leader>ga', '<Plug>(coc-codeaction-cursor)')
plug_mapper('x', '<leader>ga', '<Plug>(coc-codeaction-selected)')
-- Apply AutoFix to problem on the current line.
plug_mapper('n', '<leader>qf', '<Plug>(coc-fix-current)')

-- Show all diagnostics.
mapper("n", "<space>a", ":<C-u>CocList diagnostics<cr>")

-- Use CTRL-S for selections ranges.
mapper("n", "<C-s>", "<Plug>(coc-range-select)")
mapper("x", "<C-s>", "<Plug>(coc-range-select)")

-- Remap <C-f> and <C-b> for scroll float windows/popups.
mapper("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"')
mapper("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"')
mapper("i", "<C-f>",
  'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"')
mapper("i", "<C-b>",
  'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"')
mapper("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"')
mapper("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"')


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
mapper('n', '<F4>', ':BufferLineSortByDirectory<CR>')
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
