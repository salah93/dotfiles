-- Minimal, clean JDTLS setup that avoids lspconfig issues
-- Replace your existing java-bazel.lua with this version

return {
  -- LSP Configuration - bypassing problematic lspconfig jdtls setup
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Don't use require('lspconfig').jdtls.setup - this is causing the error
      -- Instead, set up jdtls manually using vim.lsp.start

      -- Only set up jdtls for Java files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        -- # install jdts
        --      cd ~/.local/share
        --      wget https://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
        --      tar -xzf jdt-language-server-latest.tar.gz --directory=jdtls
        --      rm jdt-language*tar.gz
        --      export PATH=$PATH:$HOME/.local/share/jdtls/bin
        callback = function()
          local current_file = vim.api.nvim_buf_get_name(0)
          local project_root = require('lspconfig.util').root_pattern('MODULE.bazel', 'WORKSPACE', '.git')(current_file)

          if not project_root then
            print("❌ No project root found for Java file")
            return
          end

          print("🚀 Starting jdtls manually for: " .. project_root)

          -- Start jdtls client manually
          vim.lsp.start({
            name = 'jdtls',
            cmd = { 'jdtls' },
            root_dir = project_root,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            settings = {
              java = {
                eclipse = {
                  downloadSources = true,
                },
                configuration = {
                  updateBuildConfiguration = "interactive",
                },
                maven = {
                  downloadSources = true,
                },
                project = {
                  sourcePaths = {
                    "src/main/java",
                    "src/test/java",
                  },
                },
                completion = {
                  importOrder = {
                    "java",
                    "javax",
                    "com",
                    "org"
                  }
                }
              }
            },
            on_attach = function(_, buffer)
              print("✅ JDTLS attached manually")

              -- Standard key mappings
              local opts = { noremap=true, silent=true, buffer=buffer }
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
              vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
              vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
              vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
              vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
              vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
              vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
              vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)

              -- Diagnostics
              vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
              vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
              vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            end,
          })
        end,
      })
    end
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
