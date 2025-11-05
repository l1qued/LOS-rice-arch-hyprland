require('toggleterm').setup({
  size = 20,
  direction = "float",
})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


-- Создаем несколько терминалов
local Terminal = require("toggleterm.terminal").Terminal
local term1 = Terminal:new({ hidden = true, direction = "float" })
local term2 = Terminal:new({ hidden = true, direction = "float" })

-- Функции для открытия терминалов
function _G.open_term1()
  term1:toggle()
end

function _G.open_term2()
  term2:toggle()
end

-- Назначаем горячие клавиши
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua open_term1()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>T", "<cmd>lua open_term2()<CR>", { noremap = true, silent = true })
