return {
    "onsails/lspkind.nvim",
    config = function()
        require('lspkind').init({
            mode = 'text',
            preset = 'default',
            ellipsis_char = '...',
        })
    end,
}
