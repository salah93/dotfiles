local config = {
    cmd = { vim.env.HOME .. "/.local/share/jdtls/bin/jdtls"},
    root_dir = vim.fs.dirname(vim.fs.find({'MODULE.bazel', '.git', 'mvnw'}, { upward = true })[1]),
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        java = {
        --eclipse = {
        --  downloadSources = true,
        --},
        --configuration = {
        --  updateBuildConfiguration = "disabled",  -- Changed from "interactive"
        --  detectProjects = false,                 -- Added to disable auto-detection
        --},
        ---- Added import settings to disable Gradle/Maven
        --import = {
        --  gradle = { enabled = false },
        --  maven = { enabled = false },
        --},
        --maven = {
        --  downloadSources = true,
        --},
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
            },
            favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
                "org.junit.jupiter.api.DynamicContainer.*",
                "org.junit.jupiter.api.DynamicTest.*",
                "org.mockito.Mockito.*",
                "org.mockito.ArgumentMatchers.*",
                "org.mockito.Answers.*"
            }
        },
        -- Enable code generation features
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
            },
            hashCodeEquals = {
                useJava7Objects = true
            },
            useBlocks = true,
            generateComments = true
        },
        -- Configure sources for content assist proposals
        contentProvider = { preferred = "fernflower" },
        }
    },
    on_attach = function(client, buffer)
        print("✅ JDTLS attached manually")

        local opts = { noremap=true, silent=true, buffer=buffer }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)

        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>jg', function()
            vim.lsp.buf.code_action({
                context = {
                    only = { "source.generate" }
                }
            })
        end, opts)

    end,

}
vim.defer_fn(function()
    -- Check if jdtls is already running
    if vim.lsp.get_clients({ name = "jdtls" })[1] then
        print("JDTLS is already running, skipping start.")
    else
        -- Start or attach to the JDTLS server
        require('jdtls').start_or_attach(config)
    end
end, 1000)
