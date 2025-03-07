return {
    "mhizaji/vim-signify",
    opts = {
    },
    config = function()
        vim.opt.signcolumn = "yes"

        vim.g.signify_sign_add = "┃"
        vim.g.signify_sign_change = "┃"
        vim.g.signify_sign_delete = "┃"
    end,
}
