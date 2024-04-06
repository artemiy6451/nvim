return {
    {
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-cmdline'},
        {'saadparwaiz1/cmp_luasnip'},
        {
            'hrsh7th/nvim-cmp',
            config = function ()
                -- Set up nvim-cmp.
                local cmp = require'cmp'

                cmp.setup({
                    snippet = {
                        expand = function(args)
                        end,
                    },
                    window = {
                        -- completion = cmp.config.window.bordered(),
                        -- documentation = cmp.config.window.bordered(),
                    },
                    formatting = {
                        format = require('lspkind').cmp_format({
                            mode = "symbol",
                            maxwidth = 50,
                            ellipsis_char = '...',
                            symbol_map = { Codeium = "⚛", }
                        })
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-j>'] = cmp.mapping.select_next_item(),
                        ['<C-k>'] = cmp.mapping.select_prev_item(),
                        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    }),
                    sources = cmp.config.sources({
                        { name = 'codeium' },
                        { name = 'nvim_lsp' },
                        { name = 'vsnip' },
                    }, {
                            { name = 'buffer' },
                            { name = 'nvim_lsp_signature_help' },
                        })
                })

                -- Set configuration for specific filetype.
                cmp.setup.filetype('gitcommit', {
                    sources = cmp.config.sources({
                        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                    }, {
                            { name = 'buffer' },
                        })
                })

                -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline({ '/', '?' }, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = 'buffer' }
                    }
                })

                -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline(':', {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = 'path' }
                    }, {
                            { name = 'cmdline' }
                        })
                })
            end
        },
    },

}
