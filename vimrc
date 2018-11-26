set nocompatible

" Install plugins with vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'valloric/MatchTagAlways'
Plugin 'scrooloose/syntastic'
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_auto_loc_list=1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_check_on_open = 1
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_loc_list_height=3
    let g:syntastic_javascript_checkers = ['eslint']
Plugin 'davidhalter/jedi-vim'
    let g:jedi#popup_on_dot = 0
    let g:jedi#show_call_signatures = 0
    let g:jedi#smart_auto_mappings = 0
Plugin 'bling/vim-airline'
Plugin 'tmhedberg/SimpylFold'
Plugin 'ctrlpvim/ctrlp.vim'
    set wildignore+=*.pyc
    set wildignore+=*.egg-info
Plugin 'chase/vim-ansible-yaml'
Plugin 'will133/vim-dirdiff'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'
Plugin 'Raimondi/delimitMate'

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
autocmd! FileType python let &colorcolumn="80,".join(range(400,999),",")



" vim_markdown
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
let g:vim_markdown_folding_disabled = 1

" Strip trailing whitespace
fun! <SID>StripTrailingWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre *.md :call <SID>StripTrailingWhitespace()

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


" Remap tab movement keys
map <Leader>[ <esc>:tabprevious<CR>
map <Leader>] <esc>:tabnext<CR>
nmap zz :%s/\s\+$//<enter>

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
nnoremap <c-l> :noh<enter>
" Remap window movement keys
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
"inoremap -- <C-K>-M
"nnoremap <C-L> <C-W><C-L>

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
" Zoom the tmux runner pane
map <Leader>vz :VimuxZoomRunner<CR>

" map timestamp
nnoremap TS <esc>:r !ds<cr> ^i
