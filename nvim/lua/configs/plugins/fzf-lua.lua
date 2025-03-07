return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    config = function()
        local fzf = require("fzf-lua")
        -- calling `setup` is optional for customization
        fzf.setup({})

        -- set keymaps
        local keymap = vim.keymap

        keymap.set("n", "<leader>ff", fzf.files, { desc = "Fzf: Find Files" })
        keymap.set(
            "n",
            "<leader>fgg",
            fzf.git_files,
            { desc = "fzf: Search Git Files" }
        )
        keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "fzf: Live Grep" })
        keymap.set("n", "<leader>fb", fzf.buffers, { desc = "fzf: Search Buffers" })
        keymap.set("n", "<leader>fw", fzf.grep_cword, { desc = "fzf: Search Word" })
    end,
}
