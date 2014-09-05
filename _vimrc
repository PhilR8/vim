set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" easily load vimrc to edit (\v)
map <leader>v :tabedit $MYVIMRC<CR>
" reload new vimrc settings on save
autocmd! bufwritepost _vimrc source $MYVIMRC

" Vundle settings
set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=C:/Vim/vimfiles/bundle/Vundle.vim/
let path='C:/Vim/vimfiles/bundle'
call vundle#begin(path)
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Keep plugin commands between vundle#begin/end.
Plugin 'Shutnik/jshint2.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'nathanealkane/vim-indent-guides'
Plugin 'jelara/vim-javascript-syntax'
Plugin 'tpope/vim-sensible'
" All plugins must be added before the following line
call vundle#end()
filetype plugin indent on
" tab labels
set showtabline=2 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}

" set current workspace to :Explore
map <F2> :cd %:p:h
" save and run python file
map <F5> :w<CR>:!python %<CR>
" open NERDTree
map <C-n> :NERDTreeToggle<CR>

set lines=50 columns=100
set number

" Fonts
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Courier\ New\ 11
  elseif has("gui_photon")
    set guifont=Courier\ New:s11
  elseif has("gui_kde")
    set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
  elseif has("x11")
    set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  else
    set guifont=Courier_New:h11:cDEFAULT
  endif
endif

" Color scheme
colorscheme molokai

syntax on

" airline customizations
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

set expandtab
set shiftwidth=4
set softtabstop=4

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

match ErrorMsg '\s\+$'
