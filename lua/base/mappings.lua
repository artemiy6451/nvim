-- jk for exit to normal mode 
vim.keymap.set("i","jk","<esc>",{noremap=true})

-- No highlight search
vim.keymap.set('n', '<leader>,', ':nohlsearch<CR>')

--Tab switch
vim.keymap.set('n', 'H', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', 'L', '<Cmd>BufferNext<CR>')
vim.keymap.set('n', '<leader>c', '<Cmd>BufferClose<CR>')

-- Quit
vim.keymap.set('n', '<leader>q', ':qa<CR>')

-- Movement lines
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv-gv")
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv-gv")

-- Moviment screen
vim.keymap.set('n', '<C-d>', "<C-d>zz")
vim.keymap.set('n', '<C-u>', "<C-u>zz")

-- Neotree
vim.keymap.set('n', '<leader>e', function()
    vim.cmd("Neotree focus toggle")
end)

-- LSP
vim.keymap.set("n", "<space>le", vim.diagnostic.open_float)
vim.keymap.set("n", "<space>lp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<space>ln", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>lq", "<cmd>Trouble diagnostics toggle<cr>")

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>ld", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<space>la", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<space>lf", function()
            vim.lsp.buf.format { async = true }
        end, opts)

        -- Restart Lsp
        vim.keymap.set("n", "<leader>lR", function()
            vim.cmd("LspRestart")
        end)
    end,
})
