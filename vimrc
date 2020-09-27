set nocompatible

" Install plugins with vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'plasticboy/vim-markdown'
Plugin 'godlygeek/tabular'
Plugin 'valloric/MatchTagAlways'
Plugin 'w0rp/ale'
    let g:ale_lint_on_text_changed = 0
    let g:ale_lint_on_enter = 0
    let g:ale_lint_on_save = 1
    let g:ale_fix_on_save = 1
    let g:ale_fixers = {
    \ 'python': ['black'],
	\ '*': ['trim_whitespace', 'remove_trailing_lines'],
    \ }
    let g:ale_linters = {
    \ 'python':  ['flake8'],
    \ }
Plugin 'jnurmine/Zenburn'
Plugin 'bling/vim-airline'
Plugin 'davidhalter/jedi-vim'
    let g:jedi#popup_on_dot = 0
    let g:jedi#show_call_signatures = 0
    let g:jedi#smart_auto_mappings = 0
Plugin 'tmhedberg/SimpylFold'
Plugin 'benmills/vimux'
Plugin 'Raimondi/delimitMate'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
    set wildignore+=*.pyc
    set wildignore+=*.egg-info
    set wildignore+=*.zip
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]node_modules$',
        \}
Plugin 'chase/vim-ansible-yaml'
Plugin 'will133/vim-dirdiff'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()
filetype plugin indent on

syntax on

" Customize file handling
autocmd BufRead,BufNewFile *.md set filetype=ghmarkdown
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd BufRead,BufNewFile *.py_tmpl set filetype=python
au BufNewFile,BufFilePre,BufRead *.sc set filetype=scala
autocmd BufRead,BufNewFile *.mako,*.mako_tmpl,*.jinja2 set filetype=html
autocmd! FileType html,xhtml,sass,scss,css,javascript,json,yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd! FileType ghmarkdown,nginx setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd! FileType python let &colorcolumn=join(range(81,999),",")
autocmd! FileType python let &colorcolumn="90,".join(range(400,999),",")


" vim_markdown
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
au BufNewFile,BufFilePre,BufRead *.rst set filetype=markdown
let g:vim_markdown_folding_disabled = 1

" Define hierarchical folds for goals
autocmd BufRead,BufNewFile *.goals set filetype=goals
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


" Configure miscellaneous settings
set autochdir      " Change directory to the folder containing the current file
set backspace=2

" ctags
set tags=tags;~

" highlight non-ascii
syntax match nonascii "[^\x00-\x7F]"
highlight nonascii guibg=Red ctermbg=2
highlight Search term=reverse ctermbg=yellow ctermfg=black guibg=Yellow
hi QuickFixLine ctermfg=blue
hi MatchParen cterm=none ctermbg=blue ctermfg=white
hi SyntasticError ctermbg=red

" get search count
map ,* *<C-O>:%s///gn<CR>
"nnoremap <c-l> :noh<enter>
" Remap window movement keys
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>
"inoremap -- <C-K>-M

" map timestamp
nnoremap TS <esc>:r !ds<cr> ^i

set history=500

" With a map leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","

" Remap tab movement keys
map <Leader>[ <esc>:tabprevious<CR>
map <Leader>] <esc>:tabnext<CR>
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Prompt for a command to run
map <leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <leader>vi :VimuxInspectRunner<CR>
" Zoom the tmux runner pane
map <leader>vz :VimuxZoomRunner<CR>

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" Add a bit extra margin to the left
set foldcolumn=0

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction


nnoremap <space>l :lnext<CR>
nnoremap <space>p :lprevious<CR>
nnoremap <space>r :lrewind<CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader>c :noh<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

color zenburn

" you complete me options
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:ansible_options = {'documentation_mapping': '<C-K>'}
