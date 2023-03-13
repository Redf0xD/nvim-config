-- local heirline = require "heirline"
if not nvim.status then return end

local colors = require 'kanagawa.colors'.setup()

--- a submodule of heirline specific functions and aliases
nvim.status.heirline = {}

--- A helper function to get the type a tab or buffer is
-- @param self the self table from a heirline component function
-- @param prefix the prefix of the type, either "tab" or "buffer" (Default: "buffer")
-- @return the string of prefix with the type (i.e. "_active" or "_visible")
function nvim.status.heirline.tab_type(self, prefix)
  local tab_type = ""
  if self.is_active then
    tab_type = "_active"
  elseif self.is_visible then
    tab_type = "_visible"
  end
  return (prefix or "buffer") .. tab_type
end

--- Make a list of buffers, rendering each buffer with the provided component
---@param component table
---@return table
nvim.status.heirline.make_buflist = function(component)
  local overflow_hl = nvim.status.hl.get_attributes("buffer_overflow", true)
  return require("heirline.utils").make_buflist(
    nvim.status.utils.surround(
      "tab",
      function(self)
        return {
          main = nvim.status.heirline.tab_type(self) .. "_bg",
          left = "sumiInk0",
          right = "sumiInk0",
        }
      end,
      {
        -- bufferlist
        init = function(self) self.tab_type = nvim.status.heirline.tab_type(self) end,
        on_click = { -- add clickable component to each buffer
          callback = function(_, minwid) vim.api.nvim_win_set_buf(0, minwid) end,
          minwid = function(self) return self.bufnr end,
          name = "heirline_tabline_buffer_callback",
        },
        { -- add buffer picker functionality to each buffer
          condition = function(self) return self._show_picker end,
          update = false,
          init = function(self)
            local bufname = nvim.status.provider.filename { fallback = "empty_file" } (self)
            local label = bufname:sub(1, 1)
            local i = 2
            while label ~= " " and self._picker_labels[label] do
              if i > #bufname then break end
              label = bufname:sub(i, i)
              i = i + 1
            end
            self._picker_labels[label] = self.bufnr
            self.label = label
          end,
          provider = function(self)
            return nvim.status.provider.str { str = self.label, padding = { left = 1, right = 1 } }
          end,
          hl = nvim.status.hl.get_attributes "buffer_picker",
        },
        component, -- create buffer component
      },
      false -- disable surrounding
    ),
    { provider = nvim.get_icon "ArrowLeft" .. " ", hl = overflow_hl },
    { provider = nvim.get_icon "ArrowRight" .. " ", hl = overflow_hl },
    function() return vim.t.bufs end, -- use astronvim bufs variable
    false -- disable internal caching
  )
end

--- Alias to require("heirline.utils").make_tablist
nvim.status.heirline.make_tablist = require("heirline.utils").make_tablist

--- Run the buffer picker and execute the callback function on the selected buffer
-- @param callback function with a single parameter of the buffer number
function nvim.status.heirline.buffer_picker(callback)
  local tabline = require("heirline").tabline
  local buflist = tabline and tabline._buflist[1]
  if buflist then
    local prev_showtabline = vim.opt.showtabline
    buflist._picker_labels = {}
    buflist._show_picker = true
    vim.opt.showtabline = 2
    vim.cmd.redrawtabline()
    local char = vim.fn.getcharstr()
    local bufnr = buflist._picker_labels[char]
    if bufnr then callback(bufnr) end
    buflist._show_picker = false
    vim.opt.showtabline = prev_showtabline
    vim.cmd.redrawtabline()
  end
end

heirline.load_colors(colors)
local heirline_opts = {
  { -- statusline
    hl = { fg = "fg", bg = "bg" },
    nvim.status.component.mode(),
    nvim.status.component.git_branch(),
    -- TODO: REMOVE THIS WITH v3
    nvim.status.component.file_info(
      (nvim.is_available "bufferline.nvim" or vim.g.heirline_bufferline)
      and { filetype = {}, filename = false, file_modified = false }
      or nil
    ),
    nvim.status.component.git_diff(),
    nvim.status.component.diagnostics(),
    nvim.status.component.fill(),
    nvim.status.component.cmd_info(),
    nvim.status.component.fill(),
    nvim.status.component.lsp(),
    nvim.status.component.treesitter(),
    nvim.status.component.nav(),
    nvim.status.component.mode { surround = { separator = "right" } },
  },
  { -- winbar
    static = {
      disabled = {
        buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
        filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
      },
    },
    init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
    fallthrough = false,
    {
      condition = function(self)
        return vim.opt.diff:get() or nvim.status.condition.buffer_matches(self.disabled or {})
      end,
      init = function() vim.opt_local.winbar = nil end,
    },
    nvim.status.component.file_info {
      condition = function() return not nvim.status.condition.is_active() end,
      unique_path = {},
      file_icon = { hl = nvim.status.hl.file_icon "winbar" },
      file_modified = false,
      file_read_only = false,
      hl = nvim.status.hl.get_attributes("winbarnc", true),
      surround = false,
      update = "BufEnter",
    },
    nvim.status.component.breadcrumbs { hl = nvim.status.hl.get_attributes("winbar", true) },
  },
  vim.g.heirline_bufferline -- TODO v3: remove this option and make bufferline default
  and { -- bufferline
    { -- file tree padding
      condition = function(self)
        self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
        return nvim.status.condition.buffer_matches(
          { filetype = { "neo%-tree", "NvimTree" } },
          vim.api.nvim_win_get_buf(self.winid)
        )
      end,
      provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid)) end,
      hl = { bg = "sumiInk0" },
    },
    nvim.status.heirline.make_buflist(nvim.status.component.tabline_file_info()), -- component for each buffer tab
    nvim.status.component.fill { hl = { bg = "sumiInk0" } }, -- fill the rest of the tabline with background color
    { -- tab list
      condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
      nvim.status.heirline.make_tablist { -- component for each tab
        provider = nvim.status.provider.tabnr(),
        hl = function(self)
          return nvim.status.hl.get_attributes(nvim.status.heirline.tab_type(self, "tab"), true)
        end,
      },
      { -- close button for current tab
        provider = nvim.status.provider.close_button { kind = "TabClose", padding = { left = 1, right = 1 } },
        hl = nvim.status.hl.get_attributes("tab_close", true),
        on_click = { callback = nvim.close_tab, name = "heirline_tabline_close_tab_callback" },
      },
    },
  }
}
heirline.setup({
  statusline = heirline_opts[1],
  winbar = heirline_opts[2],
  tabline = heirline_opts[3]
})

local augroup = vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "NvimColorScheme",
  group = augroup,
  desc = "Refresh heirline colors",
  callback = function() require("heirline.utils").on_colorscheme(colors) end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "HeirlineInitWinbar",
  group = augroup,
  desc = "Disable winbar for some filetypes",
  callback = function()
    if
        vim.opt.diff:get()
        or nvim.status.condition.buffer_matches(require("heirline").winbar.disabled or {
          buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
          filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
        }) -- TODO v3: remove the default fallback here
    then
      vim.opt_local.winbar = nil
    end
  end,
})
