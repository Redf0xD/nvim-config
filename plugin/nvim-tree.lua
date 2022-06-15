require('nvim-tree').setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  open_on_tab = true,
  update_cwd = true,
  ignore_ft_on_setup = {},
  hijack_cursor = false,
  update_to_buf_dir = {
    enable = true,
    auto_open = true,
  },
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
    update_cwd = true,
    ignore_list = {},
  },

  filters = {
    dotfiles = false,
    custom = { '.git', '.cache', '.venv', '.idea', '.vscode', '.vscode-test', '.vscode-test-user-data' },
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },

  view = {
    width = 30,
    side = 'right',
    hide_root_folder = true,
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {},
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = true,
    }
  },
  renderer = {
    indent_markers = {
      enable = false,
    },
    icons = {
      padding = ' ',
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
        -- lsp = { hint = ' ', info = ' ', warning = ' ', error = ' ' },
      },
    },
    highlight_opened_files = "icon",
    highlight_git = true,
    root_folder_modifier = ':~',
    add_trailing = false,
    group_empty = false,
  }
})
