vim.api.nvim_buf_set_keymap(0, 'i', '<F5>', '<ESC> :w <CR> :!node %<CR>', { noremap = true, silent = true})
vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', '<ESC> :w <CR> :!node %<CR>', { noremap = true, silent = true})
