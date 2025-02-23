set nocompatible

" Install plugins with vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'ruanyl/vim-gh-line'
Plugin 'plasticboy/vim-markdown'
Plugin 'godlygeek/tabular'
Plugin 'valloric/MatchTagAlways'
Plugin 'dag/vim-fish'
Plugin 'simnalamburt/vim-mundo'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'
Plugin 'w0rp/ale'
Plugin 'bling/vim-airline'

Plugin 'fatih/vim-go'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Raimondi/delimitMate'

if !has('nvim')
    Plugin 'ycm-core/YouCompleteMe'
endif

Plugin 'majutsushi/tagbar'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'chase/vim-ansible-yaml'
Plugin 'will133/vim-dirdiff'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'morhetz/gruvbox'
Plugin 'jnurmine/Zenburn'

Plugin 'aklt/plantuml-syntax'
Plugin 'scrooloose/vim-slumlord'

if !has('nvim')
    Plugin 'gergap/vim-ollama'
endif

call vundle#end()
filetype plugin indent on

let g:mapleader = " "

" Customize file handling
autocmd BufRead,BufNewFile *.rst set filetype=markdown
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd BufRead,BufNewFile *.svelte set filetype=javascript
autocmd BufRead,BufNewFile *.py_tmpl set filetype=python
autocmd BufRead,BufNewFile *.sc set filetype=scala
autocmd BufRead,BufNewFile *.mako,*.mako_tmpl,*.jinja2 set filetype=html
autocmd BufRead,BufNewFile *.goals set filetype=goals
autocmd BufRead,BufNewFile *.goals set filetype=goals

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd! FileType html,xhtml,sass,scss,css,javascript,json,yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd! FileType markdown,nginx setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd! FileType python let &l:colorcolumn="90,".join(range(400,999),",")
autocmd FileType gitcommit setlocal spell complete+=kspell
" if empty line, stay the same ('=')
" If current indent is less than next line's indent, creates a fold start ('>') with next lines indent level
" otherwise return current lines indent level
autocmd! FileType goals setlocal smartindent foldmethod=expr foldexpr=(getline(v:lnum)=~'^$')?'=':((indent(v:lnum)<indent(v:lnum+1))?'>'.(indent(v:lnum+1)/&l:shiftwidth):indent(v:lnum)/&l:shiftwidth) foldtext=getline(v:foldstart) fillchars=fold:\ "

" Define indent behavior
set tabstop=4      " Convert existing tabs to 4 spaces
set shiftwidth=4   " Use >> and << to shift indent by 4 columns
set softtabstop=4  " Insert/delete 4 spaces with TAB/BACKSPACE
set expandtab      " Insert spaces when hitting TAB
set shiftround     " Round indent to multiple of shiftwidth
set autoindent     " Align new line indent with previous line

" Define search behavior
set hlsearch       " Highlight matches
set incsearch      " Search incrementally

" Show matching brackets when text indicator is over them
set showmatch

" Configure miscellaneous settings
set autochdir      " Change directory to the folder containing the current file

" ctags
" upward search of tags file to the home directory
set tags=tags;~

" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" display
set background=light
"color zenburn
color gruvbox

set undofile

" highlight non-ascii
syntax match nonascii "[^\x00-\x7F]"
highlight nonascii guibg=red ctermbg=red
highlight Search cterm=reverse ctermbg=black ctermfg=yellow guibg=black guifg=yellow
highlight QuickFixLine ctermfg=blue guifg=blue
highlight MatchParen ctermbg=blue ctermfg=white guibg=blue guifg=white

" Disable highlight when <leader><cr> is pressed
map <silent> <leader>c :noh<cr>

" Remap window movement keys
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

" Remap tab movement keys
map <leader>[ <esc>:tabprevious<CR>
map <leader>] <esc>:tabnext<CR>
map <leader>bn :bnext<cr>
map <leader>bp :bprevious<cr>

" local-list
nnoremap <leader>l :lnext<CR>
nnoremap <leader>k :lprevious<CR>
nnoremap <leader>r :lrewind<CR>

" Fast saving
nmap <leader>w :w<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
" The structure :w !cmd means "write the current buffer piped through command"
command W w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
function! VisualSelection() range
    " save contents currently in the unnamed register
    let l:saved_reg = @"

    " this will put the yanked text into the unnamed register '@"'
    execute "normal! vgvy"

    " escape special characters
    let l:pattern = escape(@", "\\/.*'$^~[]")
    " remove trailing new lines
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    " save pattern to search register
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" <c-u> clears command line
" <c-r> allows for inserting contents of a register
" = after <c-r> means we want to insert results of next expression
" @/ is the search register we saved into in VisualSelection
vnoremap <silent> * :<C-u>call VisualSelection()<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection()<CR>?<C-R>=@/<CR><CR>
" get search count
map ,* *<C-O>:%s///gn<CR>

""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""

" vim_markdown
let g:vim_markdown_folding_disabled = 1

"ctrlp
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](node_modules|\.git|__pycache__)$',
    \}

" ale
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
    \ 'python': ['black', 'isort'],
    \ 'go': ['gofmt'],
    \ '*': ['trim_whitespace', 'remove_trailing_lines'],
    \ }
let g:ale_linters = {
    \ 'python':  ['flake8'],
    \ 'bash': ['shellcheck'],
    \ 'go':  ['golint', 'errcheck', 'deadcode', 'go vet'],
    \ }

" you-complete-me options
if !has('nvim')
    let g:ycm_autoclose_preview_window_after_completion=1
    map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
endif

let g:ansible_options = {'documentation_mapping': '<C-K>'}

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1
