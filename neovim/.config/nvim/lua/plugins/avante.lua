return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {},
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
        init = function()
            require("nvim-treesitter.configs").setup{
                ensure_installed = {
                    "markdown",
                    "markdown_inline",
                    "python",
                    "vim",
                    "lua",
                    "vimdoc",
                    "query"
                },
                sync_install = false,
                auto_install = true,
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",     -- Start selection
                        node_incremental = "grn",   -- Increment to next node
                        scope_incremental = "grc",  -- Increment to scope
                        node_decremental = "grm"    -- Decrement to previous node
                    }
                },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true
                }
            }
        end
    },
    --- The below dependencies are optional,
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  },
}
