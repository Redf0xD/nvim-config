-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- LSP Provider
  use({
    'neoclide/coc.nvim',
    branch = 'master',
    run = 'yarn install --frozen-lockfile',
  })
  -- use 'github/copilot.vim'
  use 'lewis6991/impatient.nvim'
  -- Themes
  use({
    "catppuccin/nvim",
    as = "catppuccin"
  })
  use({ 'marko-cerovac/material.nvim', opt = false })
  -- Utilities
  use 'mbbill/undotree'
  use {
    "prettier/vim-prettier",
    ft = { "html", "javascript", "typescript", "css", "less", "scss", "sass", "markdown", "vue", "json", "lua" },
    run = "yarn install",
  }
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
  })
  use({
    'b3nj5m1n/kommentary',
    config = function()
      require('kommentary.config').use_extended_mappings()
    end,
  })
  use({
    'AckslD/nvim-neoclip.lua',
    config = function()
      require('neoclip').setup()
      require('telescope').load_extension('neoclip')
    end,
  })
  use { 'lewis6991/gitsigns.nvim', config = function()
    require('gitsigns').setup()
  end }

  use({ 'tpope/vim-surround' })
  use({ "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  })

  -- Syntax Highlighting
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use('MaxMEllon/vim-jsx-pretty')
  use('pangloss/vim-javascript')
  use('styled-components/vim-styled-components')
  use('iloginow/vim-stylus')
  -- UI Plugins
  use { 'glepnir/dashboard-nvim' }
  use('nvim-lualine/lualine.nvim')
  use('p00f/nvim-ts-rainbow')
  use({ 'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
  })
  use({ 'norcalli/nvim-colorizer.lua',
  })
  use('akinsho/nvim-bufferline.lua')
  use('christoomey/vim-tmux-navigator')

  use('lukas-reineke/indent-blankline.nvim')
  use({
    'phaazon/hop.nvim',
    branch = 'v1',
    config = function()
      require 'hop'.setup({ keys = 'etovxqpdygfblzhckisuran' })
    end,
  })
  use({
    'pwntester/octo.nvim',
    opt = true,
    config = function()
      require('octo').setup()
    end,
  })
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
end)
