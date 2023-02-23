return {
  settings = {
    Lua = {
      telemetry = { enable = false },
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim", 'nvim_installation', "packer_plugins", "bit" } },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          nvim.install.home .. "/lua",
          nvim.install.config .. "/lua",
        },
      },
    },
  },
}
