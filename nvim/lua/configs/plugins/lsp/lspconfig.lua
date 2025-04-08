return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "saghen/blink.cmp",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local home = os.getenv("HOME")

        local nvim_lsp = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")

        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

            nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
            nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
            nmap("<leader>gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
            nmap("<leader>gr", "<cmd>FzfLua lsp_references<CR>", "[G]oto [R]eferences")
            nmap("<leader>gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
            nmap("<leader>D", vim.lsp.buf.type_definition, "[T]ype [D]efinition")
            nmap("K", vim.lsp.buf.hover, "Hover Documentation")
            nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
            nmap("[d", vim.diagnostic.goto_next, "Go to Next Diagnostic")
            nmap("]d", vim.diagnostic.goto_prev, "Go to Previous Diagnostic")
        end

        local capabilities = require('blink.cmp').get_lsp_capabilities()

        mason_lspconfig.setup_handlers({
            function(server)
                nvim_lsp[server].setup({})
            end,
            ["eslint"] = function()
                nvim_lsp["eslint"].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,
            ["lua_ls"] = function()
                nvim_lsp["lua_ls"].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                })
            end,
            ["gopls"] = function()
                nvim_lsp["gopls"].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,
            ["pyright"] = function()
                nvim_lsp["pyright"].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,
            ["html"] = function()
                nvim_lsp["html"].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,
            ["cssls"] = function()
                nvim_lsp["cssls"].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,
            ["stylelint_lsp"] = function()
                nvim_lsp["stylelint_lsp"].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,
            ["volar"] = function()
                nvim_lsp["volar"].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    init_options = {
                        vue = {
                            hybridMode = false,
                        },
                        typescript = {
                            tsdk = home .. "/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib/",
                        },
                    },
                })
            end,
            ["ts_ls"] = function()
                nvim_lsp["ts_ls"].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    init_options = {
                        plugins = {
                            {
                                name = "@vue/typescript-plugin",
                                -- Change this to the location the plugin is installed to
                                location = home .. "/.nvm/versions/node/v20.18.3/lib/node_modules/@vue/typescript-plugin",
                                languages = { "javascript", "typescript", "vue" },
                            },
                        },
                    },
                    filetypes = {
                        "javascript",
                        "typescript",
                        "vue",
                    },
                })
            end,
        })
    end
}
