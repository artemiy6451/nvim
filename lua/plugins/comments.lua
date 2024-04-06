return {
    {
        'terrortylor/nvim-comment',
        config = function ()
            require('nvim_comment').setup()
            vim.keymap.set('n', '<leader>/', ':CommentToggle<CR>')
        end
    },

}
