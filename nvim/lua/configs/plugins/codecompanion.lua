return {
    {
        "olimorris/codecompanion.nvim",
        config = true,
        dependencies = {
            "j-hui/fidget.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
            { "ibhagwan/fzf-lua", config = true },
        },
        opts = {
            adapters = {
                gemini = function()
                    return require("codecompanion.adapters").extend("gemini", {
                        env = {
                            api_key = "cmd:op read op://work/Gemini_API/credential --no-newline",
                        },
                        schema = {
                            model = {
                                default = "gemini-2.5-pro-exp-03-25"
                            },
                        },
                    })
                end,
            },
            strategies = {
                chat = {
                    adapter = "gemini",
                },
                inline = {
                    adapter = "gemini",
                },
            }
        },
    },
}
