return {
    -- Mason
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
    },

    -- Mason LSP Config
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "html",
                    "cssls",
                    "jsonls",
                    "vimls",
                    "bashls",
                },
                automatic_installation = true,
            })
        end,
    },

    -- LSP Config
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Автоматическая настройка серверов через mason-lspconfig
            require("mason-lspconfig").setup({
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                },
                                workspace = {
                                    library = {
                                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                                    }
                                }
                            }
                        }
                    })
                end,

                ['pyright'] = function()
                    lspconfig.pyright.setup {
                        capabilities = capabilities,
                        settings = {
                            pyright = {
                                -- Using Ruff's import organizer
                                disableOrganizeImports = true,
                            },
                            python = {
                                analysis = {
                                    -- Ignore all files for analysis to exclusively use Ruff for linting
                                    ignore = { "*" },
                                },
                            },
                        },
                    }
                end,

                ['ruff'] = function()
                    lspconfig.ruff.setup {
                        capabilities = capabilities,
                        isnit_options = {
                            settings = {
                                format = {
                                    preview = true
                                }
                            }
                        }
                    }
                end,
            })

            vim.lsp.config("vtsls", {
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                settings = {
                    vtsls = { tsserver = { globalPlugins = {} } },
                    typescript = {
                        inlayHints = {
                            parameterNames = { enabled = "literals" },
                            parameterTypes = { enabled = true },
                            variableTypes = { enabled = true },
                            propertyDeclarationTypes = { enabled = true },
                            functionLikeReturnTypes = { enabled = true },
                            enumMemberValues = { enabled = true },
                        },
                    },
                },
                before_init = function(_, config)
                    table.insert(config.settings.vtsls.tsserver.globalPlugins, {
                        name = "@vue/typescript-plugin",
                        location = vim.fn.expand(
                            "$MASON/packages/vue-language-server/node_modules/@vue/language-server"
                        ),
                        languages = { "vue" },
                        configNamespace = "typescript",
                        enableForWorkspaceTypeScriptVersions = true,
                    })
                end,
                on_attach = function(client)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            })
        end,
    }
}
