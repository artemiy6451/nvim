return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {'SmiteshP/nvim-navic'},
        },
        config = function ()
            local lspconfig = require('lspconfig')
            local navic = require('nvim-navic')

            local on_attach = function (client, bufnr)
                navic.attach(client, bufnr)
            end

            -- Bash lsp
            lspconfig.bashls.setup{
                on_attach = on_attach,
            }

            -- Lsp for python
            lspconfig.pyright.setup{
                on_attach = on_attach,
                cmd = { 'pyright-langserver', '--stdio', '-p', '~/.pyrightconfig.json'},
            }

            -- Lsp for golang
            lspconfig.gopls.setup{
                on_attach = on_attach,
            }

            -- Lsp for sql
            lspconfig.sqls.setup{
                on_attach = on_attach,
            }

            -- Lsp for emmet
            lspconfig.emmet_ls.setup({
                filetypes = { "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
                init_options = {
                  html = {
                    options = {
                      ["bem.enabled"] = true,
                    },
                  },
                }
            })

            -- Lsp for stylelint
            lspconfig.stylelint_lsp.setup({
                settings = {
                stylelintplus = {
                    validateOnSave = true,
                }
              },
                root_dir = function()
                    return vim.loop.cwd()
                end,
            })

            -- Lsp for eslint
            lspconfig.eslint.setup{
                root_dir = function()
                    return vim.loop.cwd()
                end,
            }

            -- Lsp for tsserver
            lspconfig.tsserver.setup{
                root_dir = function()
                    return vim.loop.cwd()
                end,
            }

            -- Lsp for lua
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = {
                                'vim',
                                'require'
                            },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<space>le', vim.diagnostic.open_float)
            vim.keymap.set('n', '<space>lp', vim.diagnostic.goto_prev)
            vim.keymap.set('n', '<space>ln', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>lq', vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>ld', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<space>la', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<space>lf', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)

                    -- Restart Lsp
                    vim.keymap.set('n', '<leader>lR', ':LspRestart<CR>')
                end,
            })
        end
    },
}
