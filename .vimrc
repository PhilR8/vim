set nocompatible
set noswapfile

" enable spell check for markdown and txt files
autocmd BufRead,BufNewFile *.txt,*.md setlocal spell

" vundle settings
filetype off

map <leader>v :edit $HOME/.vimrc<CR>
set ruler
set showmatch
set showmode

inoremap jk <ESC>

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Keep plugin commands between vundle#begin/end.
Plugin 'Shutnik/jshint2.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-sensible'
Plugin 'groenewege/vim-less'
Plugin 'othree/yajs.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher' " faster CtrlP results
Plugin 'mbbill/undotree'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-fugitive'
Plugin 'elzr/vim-json'
Plugin 'mhinz/vim-signify'
Plugin 'ap/vim-css-color'
Plugin 'KabbAmine/zeavim.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-jdaddy' " JSON manipulation/pretty printing
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround' " edit surrounding tags in pairs - cs<from><to>; ds<tag> to delete
Plugin 'briancollins/vim-jst' " template syntax highlighting
Plugin 'tpope/vim-vinegar' " enhanced netrw
Plugin 'edsono/vim-matchit' " % to jump between opening/closing tags
Plugin 'drmikehenry/vim-fontsize' " adjust font size <leader><leader>+/-
Plugin 'alvan/vim-closetag' " close html tags
Plugin 'heavenshell/vim-jsdoc' " plugin to generate JSDoc block comments
Plugin 'vim-multiple-cursors' " sublime-style multiple cursors
Plugin 'mxw/vim-jsx' " React JSX syntax highlighting/indenting
Plugin 'tpope/vim-eunuch' " Vim sugar for UNIX shell commands

" All plugins must be added before the following line
call vundle#end()
filetype plugin indent on

"set current workspace to :Explore
map <F2> :cd %:p:h

" Toggle undotree
nnoremap <F5> :UndotreeToggle<CR>

if has("persistent_undo")
    set undodir=~/undo
    set undofile
endif

" remove whitespace
map <F10> :%s/\s\+$//
" open NERDTree
map <C-n> :NERDTreeToggle<CR>

" delimitMate binding
imap <C-c> <CR><Esc>O

set lines=50 columns=100
set number

set encoding=utf-8
set fileencodings=utf-8

set linespace=2

" Use one of the following to define the camel characters.
" Stop on capital letters.
let g:camelchar = "A-Z"
" Also stop on numbers.
let g:camelchar = "A-Z0-9"
" Include '.' for class member, ',' for separator, ';' end-statement,
" and <[< bracket starts and "'` quotes.
let g:camelchar = "A-Z0-9.,;:{([`'\""
nnoremap <silent><C-h> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
nnoremap <silent><C-l> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
inoremap <silent><C-h> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
inoremap <silent><C-l> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
vnoremap <silent><C-h> :<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>v`>o
vnoremap <silent><C-l> <Esc>`>:<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>v`<o

" Color scheme
set background=dark

syntax enable

" airline customizations
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1

" tab settings
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
set softtabstop=4
" On pressing tab, insert 4 spaces
set expandtab

" caseless searching
set ignorecase

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" vim-signify
let g:signify_vcs_list = [ 'git' ]

" vim-json
let g:vim_json_syntax_conceal = 0

match ErrorMsg '\s\+$'

" settings only for gVim
if has ('gui_running')

    set background=dark
    colorscheme solarized8
    set guioptions -=T

endif

