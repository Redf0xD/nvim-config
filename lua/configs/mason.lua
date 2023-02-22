require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_uninstalled = "✗",
      package_pending = "⟳",
    },
  },
})

local cmd = vim.api.nvim_create_user_command
cmd("MasonUpdateAll", function() nvim.mason.update_all() end, { desc = "Update Mason Packages" })
cmd("MasonUpdate", function(opts) nvim.mason.update(opts.args) end, { nargs = 1, desc = "Update Mason Package" })
