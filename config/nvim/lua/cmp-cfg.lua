-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities
local cmp = require 'cmp'
local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')

cmp.setup {
  mapping = cmp.mapping.preset.insert({
    -- Comfirm/Complete/Abort
    -- ['<Tab>'] = cmp.mapping.confirm({ select = true --[[ use 1st if no item selected ]] }), 
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-y>'] = cmp.mapping.confirm(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-c>'] = cmp.mapping.abort(),
    ['<C-e>'] = cmp.mapping.abort(),

    -- Move
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping(function(fallback)
      cmp_ultisnips_mappings.compose { 'jump_backwards', 'select_prev_item' }(fallback)
    end,
    { 'i', 's', --[[ 'c' (to enable the mapping in command mode) ]] }
    ),
    ['<C-j>'] = cmp.mapping(function(fallback)
      cmp_ultisnips_mappings.compose { 'jump_forwards', 'select_next_item' }(fallback)
    end,
    { 'i', 's', --[[ 'c' (to enable the mapping in command mode) ]] }
    ),

    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
  }),

  sources = {
    { name = 'ultisnips', option = { priority = 99 }},
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'buffer-lines' },
    { name = 'path' },
    {
      name = 'tmux',
      option = {
        trigger_characters = {}, -- default is '.' and break my ultisnips rst snippet
      },
    },
  },

  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end,
  },

  -- https://github.com/onsails/lspkind.nvim?tab=readme-ov-file#option-2-nvim-cmp
  formatting = {
    format = require('lspkind').cmp_format({
      mode = 'symbol_text', -- show symbol+text annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- can also be a function to dynamically calculate max width such as 
      -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
      ellipsis_char = '… ', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default
    }),
  }
}

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {{
    name = 'buffer',
    keyword_length = 2,
  }}
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      keyword_length = 2,
      option = { ignore_cmds = { 'Man', '!' } }
    }
  })
})
