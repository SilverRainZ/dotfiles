-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Bootstrap lazy.nvim
-- https://lazy.folke.io/installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local PLUGIN_VIM_CONFIG = '$XDG_CONFIG_HOME/nvim/plugins/'
local islocal = os.getenv('SSH_CLIENT') == nil

require("lazy").setup({
  -- ==========
  -- Completion
  -- ==========

  { -- Collection of configurations for the built-in LSP client
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


  {
    'hrsh7th/nvim-cmp',                -- autocompletion plugin
    cond = islocal, -- disable for after/plugin/cmp_nvim_ultisnips.lua takes 997.8ms
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',            -- LSP source
      'hrsh7th/cmp-buffer',              -- vim buffer words source
      'amarakon/nvim-cmp-buffer-lines',  -- vim buffer lines source
      'hrsh7th/cmp-path',                -- filesystem path source
      'hrsh7th/cmp-cmdline',
      'andersevenrud/cmp-tmux',              -- tmux source
      'quangnguyen30192/cmp-nvim-ultisnips', -- snippet source
      'onsails/lspkind.nvim',                -- pretty completion list
    },
    config = function()
      require 'cmp-cfg'
    end
  },

  {
    'yetone/avante.nvim',
    -- https://github.com/yetone/avante.nvim/issues/544#issuecomment-2334374237
    build = 'make',
    event = 'VeryLazy',
    version = false,
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = 'perplexity',
      providers = {
        perplexity = {
          __inherited_from = 'openai',
          api_key_name = 'PERPLEXITY_API_KEY',
          endpoint = 'https://api.perplexity.ai',
          model = 'sonar-pro',

          -- https://github.com/yetone/avante.nvim/issues/2800
          -- socks5*h*: h for remote DNS!
          proxy = 'socks5h://127.0.0.1:1080',
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
      'nvim-tree/nvim-web-devicons',
      'HakonHarnes/img-clip.nvim',
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'Avante' },
        },
        ft = { 'Avante' },
      },
    },
  },

  {
    'zbirenbaum/copilot.lua',
    dependencies = {
      'copilotlsp-nvim/copilot-lsp', -- (optional) for NES functionality
    },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require 'copilot-cfg'
    end
  },

  -- ==========
  -- Formatters
  -- ==========
  {
    'fatih/vim-go',
    config = function()
      vim.cmd('source ' .. PLUGIN_VIM_CONFIG .. 'go.vim')
    end
  },
  'Vimjas/vim-python-pep8-indent',

  -- ================
  -- Syntax highlight
  -- ================
  { -- Treesitter.
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'treesitter-cfg'
    end
  },

  -- ============
  -- Fuzzy finder
  -- ============
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.7',
    lazy = true, -- rquire keys
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    keys = {
      { '<C-n>', function() require("telescope").extensions.file_browser.file_browser() end },
      { '<leader>ff', function() require('telescope.builtin').git_files() end },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end },
      { '<leader>fo', function() require('telescope.builtin').oldfiles() end },
    },
    config = function()
      require 'telescope-cfg'
    end
  },

  -- required by sphinxnotes-snippet
  'junegunn/fzf.vim',
  'junegunn/fzf',

  -- ===========
  -- UI Beautify
  -- ===========
  { -- Nord theme with ligth variant
    'rmehri01/onenord.nvim',
    config = function()
      require 'onenord-cfg'
    end
  },
  { -- See also ~/bin/light-and-dark.
    "f-person/auto-dark-mode.nvim",
    cond = islocal,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option("background", "dark")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option("background", "light")
      end,
    },
  },
  { -- notifications and LSP progress message
    'j-hui/fidget.nvim',
    config = function()
      require 'fidget-cfg'
    end
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'rmehri01/onenord.nvim',
    },
    config = function()
      require 'bufferline-cfg'
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },

  -- ============
  -- Fast editing
  -- ============
  {
    'kylechui/nvim-surround',
    config = function()
      require 'surround-cfg'
    end
  },
  {  -- snippet manager
    'SirVer/ultisnips',
    dependencies ='honza/vim-snippets',
  },
  -- Change and enhance features of * (highlight and search)
  -- ref: https://stackoverflow.com/a/13682379
  'vim-scripts/star-search',
  {
    "folke/zen-mode.nvim",
    config = function()
      require 'zen-mode-cfg'
    end
  },
  {
    'vim-voom/VOoM',
    config = function()
      vim.cmd('source ' .. PLUGIN_VIM_CONFIG .. 'voom.vim')
    end
  },
  { -- like vim-fcitx, but for macOS
    -- https://zhuanlan.zhihu.com/p/49411224
    'lyokha/vim-xkbswitch',
    cond = vim.fn.has('mac') == 1 and islocal,
    lazy = false,
    init = function()
      -- *MUST* in init function rather than config function.
      -- https://github.com/lyokha/vim-xkbswitch/issues/66#issuecomment-1627647615
      vim.cmd('source ' .. PLUGIN_VIM_CONFIG .. 'xkbswitch.vim')
    end
  },
  { -- require fcitx5-remote
    'lilydjwg/fcitx.vim',
    cond = vim.fn.has('linux') == 1 and islocal,
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },

  -- ======
  -- Others
  -- ======
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require 'toggleterm-cfg'
    end
  },
  {
    'martineausimon/nvim-lilypond-suite',
    config = function() require('nvls').setup({}) end,
  },
  'stsewd/sphinx.nvim',

  'sindrets/diffview.nvim',

  {
    'xvzc/chezmoi.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'zen-mode-cfg'
    end
  },

  {
    'LhKipp/nvim-nu',
    enabled = false, -- due to https://github.com/nushell/tree-sitter-nu/issues/219
    build = ':TSInstall nu',
    opts = {},
    dependencies = { 'nvimtools/none-ls.nvim' },
  },

  {
    "dir",
    dir = "~/git/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    config = function()
      require 'image-cfg'
    end
  }
})

-- ======================
-- Manual managed plugins
-- ======================

-- https://sphinx.silverrainz.me/snippet/
vim.cmd('source ' .. PLUGIN_VIM_CONFIG .. 'sphinxnotes-snippet.vim')
-- https://github.com/ofirgall/tmux-window-name
require 'tmux-window-name-cfg'
