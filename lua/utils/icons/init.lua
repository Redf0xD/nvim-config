local M = {}

--- Get an icon from the internal icons if it is available and return it
---@param kind string The kind of icon in astronvim.icons to retrieve
---@param padding? integer Padding to add to the end of the icon
---@return string icon
function M.get_icon(kind, padding)
  local icon_pack = "icons"
  M.icons = require('utils.icons.nerd_font')
  local icon = M[icon_pack] and M[icon_pack][kind]
  return icon and icon .. string.rep(" ", padding or 0) or ""
end

return M
