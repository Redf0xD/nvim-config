require('bufferline').setup({
  options = {
    indicator = { icon = ' ' },
    always_show_bufferline = true,
    show_buffer_close_icons = false,
    modified_icon = '●',
    left_trunc_marker = '',
    right_trunc_marker = '',
    offsets = {
      { filetype = 'NvimTree', text = "File Explorer", text_align = 'center', highlight = "Directory" },
    },
    show_tab_indicators = true,
    show_close_icon = false,
    color_icons = true,
    highlight = {
      separator = {
        fg = '#073642',
        bg = '#002b36',
      },
      separator_selected = {
        fg = '#073642',
      },
      background = {
        fg = '#657b83',
        bg = '#002b36'
      },
      buffer_selected = {
        fg = '#fdf6e3',
        bold = true,
      },
      fill = {
        bg = '#073642'
      }
    }
  },
})
