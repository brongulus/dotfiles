vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	pattern = {"*.cpp", "*.h"},
	command = ":normal gg017ja",
})
vim.api.nvim_buf_set_keymap(0, 'i', '<F4>', '<ESC> :w <CR> :!g++ -std=c++17 -Wall -Wextra -Wshadow -DLOCAL -O2 -I/mnt/Data/Documents/problems/include % && ./a.out < ./in<CR>', { noremap = true, silent = false})
vim.api.nvim_buf_set_keymap(0, 'n', '<F4>', '<ESC> :w <CR> :!g++ -std=c++17 -Wall -Wextra -Wshadow -DLOCAL -O2 -I/mnt/Data/Documents/problems/include % && ./a.out < ./in<CR>', { noremap = true, silent = false})
