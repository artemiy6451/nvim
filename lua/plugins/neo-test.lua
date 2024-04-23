return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            { "nvim-neotest/nvim-nio" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
            { "antoinemadec/FixCursorHold.nvim" },
            { 'nvim-neotest/neotest-python' },
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({
                        dap = {
                            justMyCode = false,
                            console = "integratedTerminal",
                        },
                        args = { "--log-level", "DEBUG", "--quiet" },
                        runner = "pytest",
                    })
                }
            })
            vim.keymap.set('n', '<leader>tm', ':lua require("neotest").run.run()<cr>')
            vim.keymap.set('n', '<leader>tf', ':lua require("neotest").run.run(vim.fn.expand("%"))<cr>')
            vim.keymap.set('n', '<leader>ts', ':lua require("neotest").run.stop()<cr>')
            vim.keymap.set('n', '<leader>tt', ':lua require("neotest").summary.toggle()<cr>')
        end
    },
}
