return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            'saadparwaiz1/cmp_luasnip',
        },
        build = "make install_jsregexp",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()

            local luasnip = require("luasnip")

            vim.keymap.set({ "i", "s" }, "<Tab>", function()
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
                end
            end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n", true)
                end
            end, { silent = true })
        end
    }
}
