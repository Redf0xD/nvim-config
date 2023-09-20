local M = {
  "nvim-neo-tree/neo-tree.nvim",
  event = "VimEnter",
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "Neotree",
}

function M.config()
  local get_icon = require('utils.icons').get_icon
  require("neo-tree").setup({
    auto_clean_after_session_restore = true, -- Automatically clean up broken neo-tree buffers saved in sessions
    -- source_selector provides clickable tabs to switch between sources.
    source_selector = {
      winbar = true, -- toggle to show selector on winbar
      sources = {
          { source = "filesystem", display_name = get_icon("FolderClosed", 1) .. "File" },
          { source = "buffers", display_name = get_icon("DefaultFile", 1) .. "Bufs" },
          { source = "git_status", display_name = get_icon("Git", 1) .. "Git" },
          { source = "diagnostics", display_name = get_icon("Diagnostic", 1) .. "Diagnostic" },
        },
      content_layout = "center",
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function(_) vim.opt_local.signcolumn = "auto" end,
      },
    },
    default_component_configs = {
      indent = { padding = 0 },
      icon = {
        folder_closed = get_icon "FolderClosed",
        folder_open = get_icon "FolderOpen",
        folder_empty = get_icon "FolderEmpty",
        folder_empty_open = get_icon "FolderEmpty",
        default = get_icon "DefaultFile",
      },
      modified = { symbol = get_icon "FileModified" },
      git_status = {
        symbols = {
          added = get_icon "GitAdd",
          deleted = get_icon "GitDelete",
          modified = get_icon "GitChange",
          renamed = get_icon "GitRenamed",
          untracked = get_icon "GitUntracked",
          ignored = get_icon "GitIgnored",
          unstaged = get_icon "GitUnstaged",
          staged = get_icon "GitStaged",
          conflict = get_icon "GitConflict",
        },
      },
    },
    -- see `:h neo-tree-custom-commands-global`
    commands = {
      copy_selector = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local vals = {
            ["BASENAME"] = modify(filename, ":r"),
            ["EXTENSION"] = modify(filename, ":e"),
            ["FILENAME"] = filename,
            ["PATH (CWD)"] = modify(filepath, ":."),
            ["PATH (HOME)"] = modify(filepath, ":~"),
            ["PATH"] = filepath,
            ["URI"] = vim.uri_from_fname(filepath),
          }

          local options = vim.tbl_filter(function(val) return vals[val] ~= "" end, vim.tbl_keys(vals))
          if vim.tbl_isempty(options) then
            return
          end
          table.sort(options)
          vim.ui.select(options, {
            prompt = "Choose to copy to clipboard:",
            format_item = function(item) return ("%s: %s"):format(item, vals[item]) end,
          }, function(choice)
            local result = vals[choice]
            if result then
              vim.fn.setreg("+", result)
            end
          end)
      end,
      find_in_dir = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("telescope.builtin").find_files {
            cwd = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h"),
          }
      end,
    }, -- A list of functions
    window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
      -- possible options. These can also be functions that return these options.
      width = 30, -- applies to left and right positions
      mappings = {
        ["<space>"] = false,
        ["Y"] = "copy_selector",
        ["F"] = "find_in_dir",
        ["<S-tab>"] = "prev_source",
        ["<tab>"] = "next_source",
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ["<C-j>"] = "move_cursor_down",
        ["<C-k>"] = "move_cursor_up",
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --               -- the current file is changed while the tree is open.
      },
      hijack_netrw_behavior = "open_current", -- "open_current",-- netrw disabled, opening a directory opens within the
      use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
      -- instead of relying on nvim autocmd events.
    },
  })
end

return M
