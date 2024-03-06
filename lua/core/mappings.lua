-- jk for exit to normal mode 
vim.keymap.set("i","jk","<esc>",{noremap=true})

-- No highlight search
vim.keymap.set('n', ',<leader>', ':nohlsearch<CR>')

--Tab switch
vim.keymap.set('n', 'H', 'gT',{noremap=true})
vim.keymap.set('n', 'L', 'gt',{noremap=true})
vim.keymap.set('n', 'gn', ':bn<CR>',{noremap=true})
vim.keymap.set('n', 'gp', ':bp<CR>',{noremap=true})

-- Quit
vim.keymap.set('n', '<leader>q', ':q<CR>')

-- Movement window
-- Normal mode
vim.keymap.set('n', '<C-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<C-k>', ':m .-2<CR>==')
-- Visual mode
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv-gv")
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv-gv")

