local os_name
local sysname = vim.uv.os_uname().sysname

if sysname == "Darwin" then
    os_name = "mac"
elseif sysname == "Linux" then
    os_name = "linux"
else
    print("Unsupported OS: " .. sysname)
    return
end

local jdtls_home = vim.env.HOME .. "/.local/share/jdtls"
local config = {
    cmd = {
        jdtls_home .. "/bin/jdtls",
        "-configuration", jdtls_home .. "/config_" .. os_name
    },
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
            referencedLibraries = {
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

require('jdtls').start_or_attach(config)
