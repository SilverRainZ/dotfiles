-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

packer = require('packer').startup(function()
  -- Collection of configurations for the built-in LSP client
  use 'neovim/nvim-lspconfig'
  use "lewis6991/hover.nvim"

  use 'hrsh7th/nvim-cmp'                -- autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'            -- LSP source
  use 'hrsh7th/cmp-buffer'              -- vim buffer words source
  use 'amarakon/nvim-cmp-buffer-lines'  -- vim buffer lines source
  use 'hrsh7th/cmp-path'                -- filesystem path source
  use 'hrsh7th/cmp-cmdline'
  use 'andersevenrud/cmp-tmux'          -- tmux source

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- Syntax highlight

  use 'rmagatti/goto-preview' -- Preview LSP in floating windows

  use {
      'nvim-telescope/telescope.nvim',  -- Fuzzy finder
      requires = {
          'nvim-lua/plenary.nvim',
          'nvim-telescope/telescope-file-browser.nvim',
      }
  }

  use {
      'akinsho/bufferline.nvim',
      tag = "v4.*",
      requires = 'kyazdani42/nvim-web-devicons'
  }

  use {
    'folke/trouble.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
  }

  use 'kylechui/nvim-surround'

end)

require 'lspconfig-cfg'
require 'cmp-cfg'
require 'treesitter-cfg'
require 'telescope-cfg'
require 'goto-preview-cfg'
require 'bufferline-cfg'
require 'trouble-cfg'
require 'surround'

return packer
