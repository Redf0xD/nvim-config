local home = os.getenv("HOME")
local db = require("dashboard")
-- Grep
db.default_executive = 'telescope'

-- db.preview_command = "cat | lolcat"
db.preview_file_path = home .. "/.config/nvim/static/neovim.cat"
db.preview_file_height = 12
db.preview_file_width = 80

-- Custom Header
db.custom_header = {
  '                                                                    ',
  '      ███████████           █████      ██                     ',
  '     ███████████             █████                             ',
  '     ████████████████ ███████████ ███   ███████     ',
  '    ████████████████ ████████████ █████ ██████████████   ',
  '   █████████████████████████████ █████ █████ ████ █████   ',
  ' ██████████████████████████████████ █████ █████ ████ █████  ',
  '██████  ███ █████████████████ ████ █████ █████ ████ ██████ ',
  '██████   ██  ███████████████   ██ █████████████████ ',
  '██████   ██  ███████████████   ██ █████████████████ ',
  '                                                                      ',
  '                                                                      '
}

db.custom_center = {
  { icon = '  ',
    desc = 'Recently opened files                   ',
    action = 'Telescope oldfiles ',
    shortcut = 'SPC f h' },
  { icon = '  ',
    desc = 'Find  File                              ',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'SPC f f' },
  { icon = '  ',
    desc = 'File Browser                            ',
    action = 'Telescope file_browser',
    shortcut = 'SPC f b' },
  { icon = '  ',
    desc = 'Find  word                              ',
    action = 'Telescope live_grep',
    shortcut = 'SPC f w' },
  { icon = '  ',
    desc = 'Open Personal dotfiles                  ',
    action = 'Telescope dotfiles path=' .. home .. '/.dotfiles',
    shortcut = 'SPC f d' },
}

-- Custom Footer
db.custom_footer = { ' Es fácil perder la calma, más difícil es mantenerla' }
