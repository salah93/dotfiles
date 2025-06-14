-- Minimal, clean JDTLS setup that avoids lspconfig issues
-- Replace your existing java-bazel.lua with this version

return {
  -- LSP Configuration - using nvim-jdtls instead of manual setup
  {
    'mfussenegger/nvim-jdtls',
  },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
     mapping = cmp.mapping.preset.insert({
        -- Scroll through documentation
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<A-n>'] = cmp.mapping(function(fallback)
	   if luasnip.choice_active() then
	      luasnip.change_choice(1)
	   else
	      fallback()
	   end
	end),
	['<A-p>'] = cmp.mapping(function(fallback)
	   if luasnip.choice_active() then
	      luasnip.change_choice(-1)
	   else
	      fallback()
	   end
	end),
        -- Manual completion trigger
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Close completion menu
        ['<C-e>'] = cmp.mapping.abort(),

        -- Enter confirms selection
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true
        }),

        -- TAB KEY CONFIGURATION - This is what you want!
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- If completion menu is open, select next item
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            -- If in a snippet, jump to next placeholder
            luasnip.expand_or_jump()
          else
            -- Otherwise, insert a regular tab
            fallback()
          end
        end, { 'i', 's' }), -- Insert and Select modes

        -- SHIFT+TAB for previous item
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- If completion menu is open, select previous item
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            -- If in a snippet, jump to previous placeholder
            luasnip.jump(-1)
          else
            -- Otherwise, do default shift-tab behavior
            fallback()
          end
        end, { 'i', 's' }),
      }),

        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
        formatting = {
            format = function(entry, vim_item)
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snippet]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                })[entry.source.name]
                return vim_item
            end,
        },
      })
    end,
  },

  -- Bazel syntax support
  {
    'bazelbuild/vim-bazel',
    ft = { 'bzl', 'bazel', 'BUILD' },
  },
}
