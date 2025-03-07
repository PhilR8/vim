return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    lazy = false,
    config = function()
    local configs = require("nvim-treesitter.configs")
        configs.setup({
            -- a list of parser names
            ensure_installed = {
                "css",
                "html",
                "htmldjango",
                "javascript",
                "jsdoc",
                "json",
                "lua",
                "make",
                "markdown",
                "python",
                "rust",
                "scss",
                "typescript",
                "yaml",
            },

            -- install parsers synchronously
            sync_install = false,

            -- automatically install missing parsers when entering buffer
            auto_install = true,

            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
