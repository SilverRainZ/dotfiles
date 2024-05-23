-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  -- Collection of configurations for the built-in LSP client
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "lewis6991/hover.nvim",
      'rmagatti/goto-preview', -- preview LSP in floating windows
    },
    config = function()
      require 'lspconfig-cfg'
      require 'goto-preview-cfg'
    end
  },


  -- nvim-cmp.
  {
    'hrsh7th/nvim-cmp',                -- autocompletion plugin
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',            -- LSP source
      'hrsh7th/cmp-buffer',              -- vim buffer words source
      'amarakon/nvim-cmp-buffer-lines',  -- vim buffer lines source
      'hrsh7th/cmp-path',                -- filesystem path source
      'hrsh7th/cmp-cmdline',
      'andersevenrud/cmp-tmux',              -- tmux source
      'quangnguyen30192/cmp-nvim-ultisnips', -- snippet source
    },
    config = function()
      require 'cmp-cfg'
    end
  },

  -- Treesitter.
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'treesitter-cfg'
    end
  },

  -- Telescope fuzzy finder.
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.7',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
      require 'telescope-cfg'
    end
  },

  -- UI Beautify
  { 
    'j-hui/fidget.nvim', -- notifications and LSP progress message
    config = function()
      require 'fidget-cfg'
    end
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require 'bufferline-cfg'
    end
  },

  -- Fast edit.
  {
    'kylechui/nvim-surround',
    config = function()
      require 'surround-cfg'
    end
  },
})

