-- Set Python3 host program
vim.g.python3_host_prog = '~/.virtualenvs/env/bin/python3'

-- Disable mouse
vim.opt.mouse = ''

-- Set leader key
vim.g.mapleader = " "

-- File handling
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.rst",
  command = "set filetype=markdown"
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.json",
  command = "set filetype=json"
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.svelte",
  command = "set filetype=javascript"
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.py_tmpl",
  command = "set filetype=python"
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.sc",
  command = "set filetype=scala"
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.mako", "*.mako_tmpl", "*.jinja2"},
  command = "set filetype=html"
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.goals",
  command = "set filetype=goals"
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 1 and line <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
    end
  end
})

-- Set indentation for specific file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"html", "xhtml", "sass", "scss", "css", "javascript", "json", "yaml"},
  command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"markdown", "nginx"},
  command = "setlocal tabstop=4 shiftwidth=4 softtabstop=4"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    local colorcolumn = {"90"}
    for i = 400, 999 do
      table.insert(colorcolumn, tostring(i))
    end
    vim.opt_local.colorcolumn = table.concat(colorcolumn, ",")
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  command = "setlocal spell complete+=kspell"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "goals",
  command = "setlocal smartindent foldmethod=expr foldexpr=(getline(v:lnum)=~'^$')?'=':((indent(v:lnum)<indent(v:lnum+1))?'>'.(indent(v:lnum+1)/&l:shiftwidth):indent(v:lnum)/&l:shiftwidth) foldtext=getline(v:foldstart) fillchars=fold:\\ "
})

-- Indentation settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.autoindent = true

-- Search behavior
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Show matching brackets
vim.opt.showmatch = true

-- Change directory to the folder containing the current file
vim.opt.autochdir = true

-- ctags - upward search of tags file to the home directory
vim.opt.tags = "tags;~"

-- Set scrolloff
vim.opt.scrolloff = 7

-- Ignore compiled files
vim.opt.wildignore = "*.o,*~,*.pyc"

-- Display settings
vim.opt.background = "light"
vim.cmd("colorscheme gruvbox")

-- Enable persistent undo
vim.opt.undofile = true

-- Highlight non-ascii characters
vim.cmd([[
  syntax match nonascii "[^\x00-\x7F]"
  highlight nonascii guibg=red ctermbg=red
  highlight Search cterm=reverse ctermbg=black ctermfg=yellow guibg=black guifg=yellow
  highlight QuickFixLine ctermfg=blue guifg=blue
  highlight MatchParen ctermbg=blue ctermfg=white guibg=blue guifg=white
]])

-- Key mappings
-- Disable highlight when <leader><cr> is pressed
vim.keymap.set("n", "<leader>c", ":noh<cr>", { silent = true })

-- Window movement keys
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")

-- Tab movement keys
vim.keymap.set("", "<leader>[", "<esc>:tabprevious<CR>")
vim.keymap.set("", "<leader>]", "<esc>:tabnext<CR>")
vim.keymap.set("", "<leader>bn", ":bnext<cr>")
vim.keymap.set("", "<leader>bp", ":bprevious<cr>")

-- Location list navigation
vim.keymap.set("n", "<leader>l", ":lnext<CR>")
vim.keymap.set("n", "<leader>k", ":lprevious<CR>")
vim.keymap.set("n", "<leader>r", ":lrewind<CR>")

-- Fast saving
vim.keymap.set("n", "<leader>w", ":w<cr>")

-- :W sudo saves the file
vim.api.nvim_create_user_command("W", "w !sudo tee % > /dev/null", {})

-- Visual mode related functions
vim.cmd([[
  function! VisualSelection() range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    let @/ = l:pattern
    let @" = l:saved_reg
  endfunction
]])

vim.keymap.set("v", "*", ":<C-u>call VisualSelection()<CR>/<C-R>=@/<CR><CR>", { silent = true })
vim.keymap.set("v", "#", ":<C-u>call VisualSelection()<CR>?<C-R>=@/<CR><CR>", { silent = true })
vim.keymap.set("", ",*", "*<C-O>:%s///gn<CR>")

-- Plugin configurations
-- vim_markdown
vim.g.vim_markdown_folding_disabled = 1

-- ctrlp
vim.g.ctrlp_custom_ignore = {
  dir = [[\v[\/](node_modules|\.git|__pycache__)$]],
}

-- ale
vim.g.ale_lint_on_text_changed = 0
vim.g.ale_lint_on_enter = 1
vim.g.ale_lint_on_save = 1
vim.g.ale_fix_on_save = 1
vim.g.ale_fixers = {
  python = {'black', 'isort'},
  go = {'gofmt'},
  ['*'] = {'trim_whitespace', 'remove_trailing_lines'},
}
vim.g.ale_linters = {
  python = {'flake8'},
  bash = {'shellcheck'},
  go = {'golint', 'errcheck', 'deadcode', 'go vet'},
}

-- ansible options
vim.g.ansible_options = {documentation_mapping = '<C-K>'}

-- tagbar for go
vim.g.tagbar_type_go = {
  ctagstype = 'go',
  kinds = {
    'p:package',
    'i:imports:1',
    'c:constants',
    'v:variables',
    't:types',
    'n:interfaces',
    'w:fields',
    'e:embedded',
    'm:methods',
    'r:constructor',
    'f:functions'
  },
  sro = '.',
  kind2scope = {
    t = 'ctype',
    n = 'ntype'
  },
  scope2kind = {
    ctype = 't',
    ntype = 'n'
  },
  ctagsbin = 'gotags',
  ctagsargs = '-sort -silent'
}

-- Disable tmux navigator when zooming the Vim pane
vim.g.tmux_navigator_disable_when_zoomed = 1

-- Load lazy.nvim configuration
require("config.lazy")
