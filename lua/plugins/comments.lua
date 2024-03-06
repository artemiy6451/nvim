return {
    {
        'terrortylor/nvim-comment',
        config = function ()
            vim.keymap.set('n', '<leader>/', ':CommentToggle<CR>')
        end
    },

}
