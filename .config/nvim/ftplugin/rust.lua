vim.api.nvim_buf_set_keymap(0, 'i', '<F4>', '<ESC> :w <CR> :!cargo run<CR>', { noremap = true, silent = false})
vim.api.nvim_buf_set_keymap(0, 'n', '<F4>', '<ESC> :w <CR> :!cargo run<CR>', { noremap = true, silent = false})
