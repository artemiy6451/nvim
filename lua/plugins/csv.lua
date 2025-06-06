return {
    "chrisbra/csv.vim",
    ft = "csv",
    config = function()
        -- Force loading of ftplugin before syntax to avoid the error
        vim.cmd([[
      augroup CSVFix
      autocmd!
      autocmd FileType csv runtime! ftplugin/csv.vim
      augroup END
      ]])
    end,
}
