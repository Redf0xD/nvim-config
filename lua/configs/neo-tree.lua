require("neo-tree").setup({
  close_if_last_window = true,
  enable_diagnostics = false,
  source_selector = {
    winbar = true,
    content_layout = "center",
    tab_labels = {
      filesystem = nvim.get_icon "FolderClosed" .. " File",
      buffers = nvim.get_icon "DefaultFile" .. " Bufs",
      git_status = nvim.get_icon "Git" .. " Git",
      diagnostics = nvim.get_icon "Diagnostic" .. " Diagnostic",
    },
  },
  default_component_configs = {
    indent = { padding = 0 },
    icon = {
      folder_closed = nvim.get_icon "FolderClosed",
      folder_open = nvim.get_icon "FolderOpen",
      folder_empty = nvim.get_icon "FolderEmpty",
      default = nvim.get_icon "DefaultFile",
    },
    git_status = {
      symbols = {
        added = nvim.get_icon "GitAdd",
        deleted = nvim.get_icon "GitDelete",
        modified = nvim.get_icon "GitChange",
        renamed = nvim.get_icon "GitRenamed",
        untracked = nvim.get_icon "GitUntracked",
        ignored = nvim.get_icon "GitIgnored",
        unstaged = nvim.get_icon "GitUnstaged",
        staged = nvim.get_icon "GitStaged",
        conflict = nvim.get_icon "GitConflict",
      },
    },
  },
  window = {
    width = 30,
    mappings = {
      ["<space>"] = false, -- disable space until we figure out which-key disabling
      o = "open",
      H = "prev_source",
      L = "next_source",
    },
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        O = "system_open",
        h = "toggle_hidden",
      },
    },
    commands = {
      system_open = function(state) nvim.system_open(state.tree:get_node():get_id()) end,
    },
  },
  event_handlers = {
    { event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
  },
})
