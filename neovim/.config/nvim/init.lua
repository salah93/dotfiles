-- Set Python3 host program
vim.g.python3_host_prog = '~/.virtualenvs/env/bin/python3'

-- Load lazy.nvim configuration
require("config.lazy")

-- Plugin configurations
-- vim_markdown
vim.g.vim_markdown_folding_disabled = 1

-- ctrlp
vim.g.ctrlp_custom_ignore = {
  dir = [[\v[\/](node_modules|\.git|__pycache__|env|.*\.egg-info)$]],
}
vim.g.ctrlp_max_files = 0

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
  -- use jdtls lsp for java
  java = {},
  python = {'flake8'},
  bash = {'shellcheck'},
  go = {'golint', 'errcheck', 'deadcode', 'go vet'},
}

-- ansible options
vim.g.ansible_options = {documentation_mapping = '<C-X>'}

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

vim.g.tmux_navigator_disable_when_zoomed = 1
require("luasnip.loaders.from_lua").load()
require("luasnip").config.set_config({
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
})
