return {
    "mhinz/vim-signify",
    opts = {
    },
    config = function()
        vim.o.signcolumn = "yes:1"

        vim.g.signify_sign_add = "┃"
        vim.g.signify_sign_change = "┃"
        vim.g.signify_sign_delete = "┃"
    end,
}
