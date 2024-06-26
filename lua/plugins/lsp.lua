return {
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "j-hui/fidget.nvim",
            "folke/trouble.nvim",
        },

        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            require("fidget").setup()

            mason.setup({
                ensure_installed = { "bash-language-server",
                    -- backend
                    "pyright",
                    "gopls",
                    "sqls",
                    -- frontend
                    "emmet-ls",
                    "stylelint-lsp",
                    "eslint",
                    "tsserver",
                    "volar",
                    -- other
                    "lua-language-server",
                },

            })
            mason_lspconfig.setup({
                handlers = {
                    function(server_name) -- default handler (optional)
                        lspconfig[server_name].setup {
                            root_dir = function(...)
                                return require("lspconfig.util").root_pattern(".git")(...)
                            end,
                        }
                    end,
                    -- Next, you can provide targeted overrides for specific servers.
                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup {
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" }
                                    }
                                }
                            }
                        }
                    end,

                    ["tsserver"] = function()
                        local mason_registry = require('mason-registry')
                        local vue_language_server_path = mason_registry.get_package('vue-language-server')
                            :get_install_path() .. '/node_modules/@vue/language-server'
                        lspconfig.tsserver.setup {
                            init_options = {
                                plugins = {
                                    {
                                        name = '@vue/typescript-plugin',
                                        location = vue_language_server_path,
                                        languages = { 'vue' },
                                    },
                                },
                            },
                            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                        }
                    end
                },
            })


            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<space>le", vim.diagnostic.open_float)
            vim.keymap.set("n", "<space>lp", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "<space>ln", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<space>lq", function()
                require("trouble").toggle("document_diagnostics")
            end)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                    vim.keymap.set("n", "<space>ld", vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<space>la", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<space>lf", function()
                        vim.lsp.buf.format { async = true }
                    end, opts)

                    -- Restart Lsp
                    vim.keymap.set("n", "<leader>lR", function()
                        vim.cmd("LspRestart")
                    end)
                end,
            })
        end
    },
}
