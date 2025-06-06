return {
    {
        'mfussenegger/nvim-lint',
        config = function()
            require('lint').linters_by_ft = {
                -- markdown = {'vale',},
                python = { 'mypy', 'ruff' },
            }

            vim.api.nvim_create_autocmd({ "TextChanged", "BufWritePost", "BufRead", "InsertChange" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end
    },
}
