-- Space as leader map
vim.g.mapleader = " "

-- jk for exit to normal mode 
vim.keymap.set("i","jk","<esc>",{noremap=true})

-------------------
----- NeoTree -----
-------------------
vim.keymap.set('n', '<leader>e', ':Neotree float focus toggle<CR>')
-- Show buffers 
vim.keymap.set('n', '<leader>b', ':Neotree float toggle show buffers<CR>')
-- Show Git
vim.keymap.set('n', '<leader>g', ':Git<CR>')

-- No highlight search
vim.keymap.set('n', ',<leader>', ':nohlsearch<CR>')

--Tab switch
vim.keymap.set('n', 'H', 'gT',{noremap=true})
vim.keymap.set('n', 'L', 'gt',{noremap=true})
vim.keymap.set('n', 'gn', ':bn<CR>',{noremap=true})
vim.keymap.set('n', 'gp', ':bp<CR>',{noremap=true})

-- Toggle comment
vim.keymap.set('n', '<leader>/', ':CommentToggle<CR>')

-- Undo Tree
vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)

-- Quit
vim.keymap.set('n', '<leader>q', ':q<CR>')

-- Restart Lsp
vim.keymap.set('n', '<leader>lR', ':LspRestart<CR>')

-------------------
----- NeoTest -----
-------------------

vim.keymap.set('n', '<leader>tm', ':lua require("neotest").run.run()<cr>')
vim.keymap.set('n', '<leader>tf', ':lua require("neotest").run.run(vim.fn.expand("%"))<cr>')
vim.keymap.set('n', '<leader>ts', ':lua require("neotest").run.stop()<cr>')
vim.keymap.set('n', '<leader>tt', ':lua require("neotest").summary.toggle()<cr>')

-- Movement window
-- Normal mode
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==')
-- Visual mode
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv-gv")
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv-gv")

