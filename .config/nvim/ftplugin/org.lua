vim.api.nvim_buf_set_keymap(0, 'i', '<F4>', '<ESC> :w <CR> :!org-pdf %<cr>', { noremap = true, silent = false})
vim.api.nvim_buf_set_keymap(0, 'n', '<F4>', '<ESC> :w <CR> :!org-pdf %<CR>', { noremap = true, silent = false})
vim.api.nvim_buf_set_keymap(0, 'i', '<F5>', "<ESC> :w <CR> :r! inkscape-figures create ./figures/", { noremap = true, silent = false})
vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', "<ESC> :w <CR> :r! inkscape-figures create ./figures/", { noremap = true, silent = false})
