vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_root_folder_modifier = ':~'
vim.g.nvim_tree_add_trailing = 0
vim.g.vim_tree_tab_open = 1
vim.g.nvim_tree_group_empty = 0
vim.g.nvim_tree_width_allow_resize = 1
vim.g.nvim_tree_icon_padding = ' '

vim.g.nvim_tree_icons = {
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
  lsp = { hint = ' ', info = ' ', warning = ' ', error = ' ' },
}

require('nvim-tree').setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  open_on_tab = false,
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
    custom = { '.git' },
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },

  view = {
    width = 30,
    height = 30,
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
      enable = true,
    },
  }
})
vim.cmd('highlight NvimTreeFolderIcon guibg=blue')
