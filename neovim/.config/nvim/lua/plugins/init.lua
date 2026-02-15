return {
    {"ellisonleao/gruvbox.nvim", priority = 1000, config = true},
    "tpope/vim-surround",
    "tpope/vim-fugitive",
    "ruanyl/vim-gh-line",
    "plasticboy/vim-markdown",
    "godlygeek/tabular",
    "valloric/MatchTagAlways",
    "dag/vim-fish",
    "simnalamburt/vim-mundo",
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {}
    },
    "bling/vim-airline",
    "fatih/vim-go",
    "tmhedberg/SimpylFold",
    "Raimondi/delimitMate",
    "majutsushi/tagbar",
    "chase/vim-ansible-yaml",
    "will133/vim-dirdiff",
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    "jnurmine/Zenburn",
    "aklt/plantuml-syntax",
    "scrooloose/vim-slumlord",
    "ctrlpvim/ctrlp.vim",
    {
        'neoclide/coc.nvim',
        branch = 'release'
    },
    "w0rp/ale",
    {
        "vimwiki/vimwiki",
        event = "BufEnter *.md",
        keys = {
            { "<leader>ww", desc = "Open wiki index" },
            { "<leader>wi", desc = "Open diary index" },
        },
        init = function()
            vim.g.vimwiki_list = {
                {
                    syntax= 'markdown',
                    ext= 'md',
                    path= '~/Dropbox/journal' ,
                }
            }
            vim.g.vimwiki_global_ext = 0
        end

    }
}
