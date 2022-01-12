set nocompatible
filetype plugin indent on

" -------------------------------------------------------------------------------------
"  PLUGINS
" -------------------------------------------------------------------------------------

call plug#begin('~/AppData/Local/nvim/plugged')
" below are some vim plugin for demonstration purpose
Plug 'joshdick/onedark.vim'
Plug 'overcache/NeoSolarized'
Plug 'scrooloose/nerdcommenter'
Plug 'groenewege/vim-less'
Plug 'kien/ctrlp.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-jdaddy' " JSON manipulation/pretty printing
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-vinegar' " enhanced netrw
Plug 'drmikehenry/vim-fontsize' " adjust font size <leader><leader>+/-
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'pangloss/vim-javascript'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'equalsraf/neovim-gui-shim'
Plug 'cohama/lexima.vim' " closes {, [, etc
Plug 'andymass/vim-matchup' " improves % matching
Plug 'yuezk/vim-js' " JavaScript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim' " typescript syntax highlighting
Plug 'maxmellon/vim-jsx-pretty' " .jsx and .tsx syntax highlighting
Plug 'vim-test/vim-test' " vim test runner - :TestNearest to use
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'github/copilot.vim'
call plug#end()

" -------------------------------------------------------------------------------------
"  GENERAL
" -------------------------------------------------------------------------------------

set termguicolors
colorscheme NeoSolarized

" set hidden " hidden allows you to move away from buffer without saving
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes

" do not add newlines at end of file - current devteam request
set nofixendofline

" easily load vimrc to edit (\v)
map <leader>v :edit $MYVIMRC<CR>

" enable spell check for markdown and txt files
autocmd BufRead,BufNewFile *.txt,*.md setlocal spell

" remap Escape to jk
inoremap jk <ESC>

" disable swap files
set noswapfile

" tab settings
" use tab and display it as four spaces wide.
" NOTE - it's the actual tab character - it is not four spaces.
set tabstop=4
set shiftwidth=4
set expandtab

" caseless searching
set ignorecase

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Toggle undotree
nnoremap <F5> :UndotreeToggle<CR>

" set current file director as working directory
map <F2> :cd %:p:h

if has("persistent_undo")
	set undodir=~/.vim/undo
	set undofile
endif

" remove whitespace
map <F10> :%s/\s\+$//

set number

" airline customizations
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

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

if has("gui_running")
	set guioptions-=T " no toolbar
	set guioptions-=m " no menus
	set guioptions-=r " no scrollbar on the right
	set guioptions-=R " no scrollbar on the right
	set guioptions-=l " no scrollbar on the left
	set guioptions-=b " no scrollbar on the bottom
	set guioptions=aiA
	set mouse=a
endif

" Mouse in terminal!!! (good for resizing splits)
if has('mouse')
	set mouse=a
	"set ttymouse=xterm2
endif

" -------------------------------------------------------------------------------------
"  COC FUNCTIONS
" -------------------------------------------------------------------------------------

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Give more space for displaying messages
set cmdheight=2



" ------ vim-closetag config -------------------------------
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.js,*.jsx,*.ts,*.tsx"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js,*.erb,*.tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" ------ vim-matchup config --------------------------------
let g:matchup_matchparen_enabled = 0

" ------ vim-jsx-prett config ------------------------------
"let g:vim_jsx_pretty_highlight_close_tag = 1
let g:vim_jsx_pretty_colorful_config = 1

" -------------------------------------------------------------------------------------
"  SKELETONS
" -------------------------------------------------------------------------------------

" React / Material-UI
nnoremap ,rmc :-1read ~/repos/vim/skeleton/react-mui-class<CR>
nnoremap ,rmf :-1read ~/repos/vim/skeleton/react-mui-func<CR>
nnoremap ,rrc :-1read ~/repos/vim/skeleton/react-redux-container<CR>
nnoremap ,rmtf :-1read ~/repos/vim/skeleton/react-mui-ts-func<CR>
nnoremap ,jrt :-1read ~/repos/vim/skeleton/jest-react-test<CR>

" Vue
nnoremap ,vsf :-1read ~/repos/vim/skeleton/vue-single-file-component<CR>

" ------ set default directory -----------------------------
:cd ~/repos


" -------------------------------------------------------------------------------------
"  Github Copilot Settings
" -------------------------------------------------------------------------------------

" set accept current suggestion to CTRL-J
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
