return {
    {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'onsails/lspkind.nvim' },
        { 'L3MON4D3/LuaSnip' },
        {
            'hrsh7th/nvim-cmp',
            config = function()
                -- Set up nvim-cmp.
                local cmp = require('cmp')
                local lspkind = require('lspkind')

                cmp.setup({
                    formatting = {
                        format = lspkind.cmp_format({
                            mode = 'symbol',          -- show only symbol annotations
                            maxwidth = 50,            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                            ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                        })
                    },
                    snippet = {
                        expand = function(args)
                            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                        end,
                    },
                    window = {
                        completion = cmp.config.window.bordered(),
                        documentation = cmp.config.window.bordered(),
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
                    sources = cmp.config.sources(
                        {
                            { name = 'codeium' },
                            { name = 'nvim_lsp' },
                            { name = 'luasnip' },
                        },
                        {
                            { name = 'buffer' },
                            { name = 'nvim_lsp_signature_help' },
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
                    sources = cmp.config.sources(
                        {
                            { name = 'path' }
                        },
                        {
                            { name = 'cmdline' }
                        })
                })
            end
        },
    },

}
