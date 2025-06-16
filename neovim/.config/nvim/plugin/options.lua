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
vim.opt.background = "dark"
vim.cmd([[colorscheme gruvbox]])

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
