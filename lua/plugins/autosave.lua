return {
    {
        'pocco81/auto-save.nvim',
        config = function()
            require('auto-save').setup({
                enable = true,
                condition = function(buf)
                    if vim.bo[buf].filetype == "harpoon" then
                        return false
                    end

                    local fn = vim.fn
                    local utils = require("auto-save.utils.data")

                    if
                        fn.getbufvar(buf, "&modifiable") == 1 and
                        utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
                        return true -- met condition(s), can save
                    end
                    return false    -- can't save
                end,
                execution_message = {
                    message = function() -- message to print on save
                        return ("Saved!")
                    end,
                    dim = 0.18,              -- dim the color of `message`
                    cleaning_interval = 425, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
                },
            })
        end
    },
}
