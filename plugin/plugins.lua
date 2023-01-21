local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end]]
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP Provider
  use({ 'neoclide/coc.nvim',
    branch = 'master',
    run = 'pnpm install', })


  -- use 'pangloss/vim-javascript'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  use 'lewis6991/impatient.nvim'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  -- Themes
  use({
    "catppuccin/nvim",
    as = "catppuccin"
  })
  use({ 'marko-cerovac/material.nvim', opt = false })
  -- Utilities
  use 'mbbill/undotree'
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

  use 'dinhhuy258/git.nvim' -- For git blame & browse
  use({ 'tpope/vim-surround' })
  use({ "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  })
  use 'windwp/nvim-ts-autotag'
  -- Syntax Highlighting
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  -- use('styled-components/vim-styled-components')

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
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
