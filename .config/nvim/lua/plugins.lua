-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

packer = require('packer').startup(function()
  -- Collection of configurations for the built-in LSP client
  use 'neovim/nvim-lspconfig'
  -- Beautify LSPs hover.
  use 'JASONews/glow-hover'

  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp

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
      tag = "v2.*",
      requires = 'kyazdani42/nvim-web-devicons'
  }

end)

require 'lspconfig-cfg'
require 'cmp-cfg'
require 'treesitter-cfg'
require 'telescope-cfg'
require 'goto-preview-cfg'
require 'bufferline-cfg'

return packer
