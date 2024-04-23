return {
    'kdheepak/lazygit.nvim',
    config = function()
        vim.keymap.set('n', '<leader>g', function()
            vim.cmd("LazyGit")
        end)
    end
}
