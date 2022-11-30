require('nvim-tree').setup({
  disable_netrw = true,
  hijack_netrw = true,
  update_cwd = true,
  hijack_cursor = true,
  prefer_startup_root = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },

  update_focused_file = {
    enable = true,
    update_root = true,
  },

  filters = {
    dotfiles = false,
    custom = { '.git', '.cache', '.venv', '.idea', '.vscode', '.vscode-test', '.vscode-test-user-data' },
    exclude = { '.gitignore' },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 300,
  },

  view = {
    width = 30,
    side = 'right',
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  actions = {
    change_dir = {
      enable = true,
      global = true,
    },
  },
  renderer = {
    indent_markers = {
      enable = false,
    },
    icons = {
      padding = ' ',
      webdev_colors = true,
      glyphs = {
        default = '',
        symlink = '',
        git = {
          unstaged = '✗',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '★',
          deleted = '',
          ignored = '◌',
        },
        folder = {
          default = '',
          open = '',
          arrow_open = '',
          arrow_closed = '',
          empty = ' ',
          empty_open = ' ',
          symlink = '',
          symlink_open = '',
        },
      },
    },
    highlight_opened_files = "icon",
    highlight_git = true,
    root_folder_modifier = ':~',
    add_trailing = false,
    group_empty = false,
  }
})
