return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
    },
    config = function()
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

        mason_lspconfig.setup_handlers({
            function(server)
                nvim_lsp[server].setup({})
            end,
            ["ts_ls"] = function()
                nvim_lsp["ts_ls"].setup({
                    on_attach = on_attach,
                })
            end,
            ["eslint"] = function()
                nvim_lsp["eslint"].setup({
                    on_attach = on_attach,
                })
            end,
            ["lua_ls"] = function()
                nvim_lsp["lua_ls"].setup({
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
                    on_attach = on_attach,
                })
            end,
            ["pyright"] = function()
                nvim_lsp["pyright"].setup({
                    on_attach = on_attach,
                })
            end,
            ["html"] = function()
                nvim_lsp["html"].setup({
                    on_attach = on_attach,
                })
            end,
            ["cssls"] = function()
                nvim_lsp["cssls"].setup({
                    on_attach = on_attach,
                })
            end,
            ["stylelint_lsp"] = function()
                nvim_lsp["stylelint_lsp"].setup({
                    on_attach = on_attach,
                })
            end,
            ["volar"] = function()
                nvim_lsp["volar"].setup({
                    on_attach = on_attach,
                })
            end,
        })
    end
}
