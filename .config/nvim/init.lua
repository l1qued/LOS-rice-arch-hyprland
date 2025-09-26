vim.opt.number = true

vim.keymap.set('n', '<C-e>', ':Explore<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-w>', ':tabclose<CR>', { noremap = true, silent = true })

vim.cmd([[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NonText guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    highlight Folded guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
    highlight SignColumn guibg=NONE ctermbg=NONE
    highlight NormalFloat guibg=NONE ctermbg=NONE
    highlight FloatBorder guibg=NONE ctermbg=NONE
]])

vim.api.nvim_create_augroup("TransparentBG", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    group = "TransparentBG",
    pattern = "*",
    callback = function()
        vim.cmd([[
            highlight Normal guibg=NONE ctermbg=NONE
            highlight NonText guibg=NONE ctermbg=NONE
            highlight LineNr guibg=NONE ctermbg=NONE
            highlight Folded guibg=NONE ctermbg=NONE
            highlight EndOfBuffer guibg=NONE ctermbg=NONE
        ]])
    end
})
