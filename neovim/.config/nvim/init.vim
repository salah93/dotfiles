lua vim.g.python3_host_prog = '~/.virtualenvs/env/bin/python3'
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
lua require("config.lazy")
set mouse=
