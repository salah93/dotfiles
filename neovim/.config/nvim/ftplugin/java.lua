local config = {
    cmd = { '/Users/sahme61/.local/share/jdtls/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
            settings = {
              java = {
                eclipse = {
                  downloadSources = true,
                },
                configuration = {
                  updateBuildConfiguration = "disabled",  -- Changed from "interactive"
                  detectProjects = false,                 -- Added to disable auto-detection
                },
                -- Added import settings to disable Gradle/Maven
                import = {
                  gradle = { enabled = false },
                  maven = { enabled = false },
                },
                maven = {
                  downloadSources = true,
                },
                project = {
                  sourcePaths = {
                    "src/main/java",
                    "src/test/java",
                  },
                  referencedLibraries = {              -- Added back the JAR references
                    "bazel-*/**/*.jar",
                  }
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

    on_attach = function(client, buffer)
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

}
require('jdtls').start_or_attach(config)
