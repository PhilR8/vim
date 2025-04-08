-- Keymappings
vim.api.nvim_set_keymap("n", "<leader>v", ":edit $MYVIMRC<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F10>", ":%s/\\s\\+$//<CR>", { noremap = true })

-- Skeletons
vim.api.nvim_set_keymap("n", ",vca", ":read ~/repos/vim/skeleton/vue-composition-api<CR>", { noremap = true })
