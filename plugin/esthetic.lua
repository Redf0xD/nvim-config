-- Print the line number in front of each line
vim.wo.number = true
vim.o.number = true

-- Show the line number relative to the line with the cursor in front of each line
vim.wo.relativenumber = true
vim.o.relativenumber = true

-- Lines longer than the width of the window will wrap and displaying continues on the next line
vim.wo.wrap = true
vim.o.wrap = true

-- But don't break words, only 'by words'
vim.wo.linebreak = true

-- Will put the new window below the currentone
vim.o.splitbelow = true

-- Will put the new window right of the current one
vim.o.splitright = true

-- Enables 24-bit RGB color in TUI
vim.o.termguicolors = true

-- Dark Background
vim.o.background = 'dark'

-- Use Emoji
vim.o.emoji = true

-- Highlight the screen line of the cursor with CursorLine
vim.wo.cursorline = true

vim.o.pumheight = 10

-- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.signcolumn = "yes"

vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.updatetime = 300
