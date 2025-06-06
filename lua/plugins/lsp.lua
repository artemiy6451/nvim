return {
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "folke/trouble.nvim",
        },

        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            require("trouble").setup{}

            mason.setup({
                ensure_installed = {
                    -- backend
                    "bash-language-server",

                    "pyright",
                    "ruff",

                    "gopls",

                    "sqls",

                    "jdtls",

                    "arduino-language-server",

                    "clangd",

                    "lua-language-server",

                    -- frontend
                    "tsserver",
                    "volar",
                },
            })

            mason_lspconfig.setup({
                handlers = {
                    function(server_name) -- Default handler (for all servers not explicitly set)
                        lspconfig[server_name].setup {}
                    end,

                    ['pyright'] = function()
                        lspconfig.pyright.setup {
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
                            init_options = {
                                settings = {
                                    format = {
                                        preview = true
                                    }
                                }
                            }
                        }
                    end,

                    ["clangd"] = function()
                        lspconfig.clangd.setup {
                            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "arduino" },
                        }
                    end,

                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup {
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = "LuaJIT"
                                    },
                                    diagnostics = {
                                        globals = { "vim" }
                                    },
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
                    end,
                },
            })
        end
    },
}
