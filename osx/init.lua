local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'editorconfig/editorconfig-vim'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim' -- typescript syntax highlighting
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar' -- enhanced netrw
Plug 'mhinz/vim-signify'
Plug 'neoclide/coc.nvim'
Plug 'github/copilot.vim'
Plug("iamcco/markdown-preview.nvim", { ["do"] = vim.fn["mkdp#util#install"], ["for"] = { "markdown", "vim-plug" } })
Plug 'nvim-telescope/telescope-ui-select.nvim'

vim.call('plug#end')

-- General settings
vim.opt.termguicolors = true
vim.cmd [[colorscheme onedark]]
vim.opt.syntax = "on"
vim.opt.number = true
vim.opt.fixendofline = false
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.ignorecase = true

-- Keymappings
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>v", ":edit $MYVIMRC<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F10>", ":%s/\\s\\+$//<CR>", { noremap = true })

-- Mouse support
if vim.fn.has "mouse" then
  vim.opt.mouse = "a"
end

-- Persistent undo
--if vim.fn.has "persistent_undo" then
  --vim.opt.undodir = "~/.vim/undo"
  --vim.opt.undofile = true
--end

-- Lightline customizations
vim.g.lightline = {
  active = {
    left = {
      { "mode", "paste" },
      { "gitbranch", "readonly", "filename", "modified" },
    },
  },
  component_function = {
    gitbranch = "FugitiveHead",
  },
}

-- COC settings
vim.opt.encoding = "utf-8"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

-- COC keymappings
vim.api.nvim_set_keymap("i", "<TAB>", [[coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()]], { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { expr = true })
vim.api.nvim_set_keymap("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], { silent = true, expr = true })

vim.cmd [[
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]]

if vim.fn.has "nvim" then
  vim.api.nvim_set_keymap("i", "<c-space>", [[coc#refresh()]], { silent = true, expr = true })
else
  vim.api.nvim_set_keymap("i", "<c-@>", [[coc#refresh()]], { silent = true, expr = true })
end

vim.api.nvim_set_keymap("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
vim.api.nvim_set_keymap("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })
vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.api.nvim_set_keymap("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
vim.api.nvim_set_keymap("n", "gi", "<Plug>(coc-implementation)", { silent = true })
vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", { silent = true })
--vim.api.nvim_set_keymap("n", "K", ":call <SID>show_documentation()<CR>", { silent = true })

vim.cmd [[
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
]]

vim.api.nvim_set_keymap("n", "<leader>rn", "<Plug>(coc-rename)", { noremap = true })
vim.api.nvim_set_keymap("x", "<leader>f", "<Plug>(coc-format-selected)", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>f", "<Plug>(coc-format-selected)", { noremap = true })
vim.api.nvim_set_keymap("x", "<leader>a", "<Plug>(coc-codeaction-selected)", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>a", "<Plug>(coc-codeaction-selected)", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ac", "<Plug>(coc-codeaction)", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>qf", "<Plug>(coc-fix-current)", { noremap = true })

vim.cmd [[
augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
]]

vim.api.nvim_set_keymap("n", "<space>a", ":<C-u>CocList diagnostics<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>e", ":<C-u>CocList extensions<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>c", ":<C-u>CocList commands<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>o", ":<C-u>CocList outline<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>s", ":<C-u>CocList -I symbols<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>j", ":<C-u>CocNext<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>k", ":<C-u>CocPrev<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>p", ":<C-u>CocListResume<CR>", { silent = true })

vim.opt.cmdheight = 2

-- NERDCommenter customizations
vim.cmd [[
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction

function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
]]

-- Skeletons
vim.api.nvim_set_keymap("n", ",rmc", ":-1read ~/repos/vim/skeleton/react-mui-class<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", ",rmf", ":-1read ~/repos/vim/skeleton/react-mui-func<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", ",rrc", ":-1read ~/repos/vim/skeleton/react-redux-container<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", ",rmtf", ":-1read ~/repos/vim/skeleton/react-mui-ts-func<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", ",jrt", ":-1read ~/repos/vim/skeleton/jest-react-test<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", ",vsf", ":-1read ~/repos/vim/skeleton/vue-single-file-component<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", ",vca", ":-1read ~/repos/vim/skeleton/vue-composition-api<CR>", { noremap = true })
