vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	pattern = {"*.cpp", "*.h"},
	command = ":normal gg017ja",
})

vim.api.nvim_create_user_command("CFTest", function()
	vim.cmd.vnew()

	vim.fn.jobstart({"cf", "test"}, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if data then
				vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), -1, -1, false, data)
				-- vim.api.nvim_buf_set_options(vim.api.nvim_get_current_buf(), 'modifiable', false)
			end
		end,
		on_stderr = function(_, data)
			if data then
				vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), -1, -1, false, data)
			end
		end,
	})
end, {})

-- F1: Save, copy entire text and test using oj
-- F3: Paste clipboard content & compile file & run against in
-- F4: Compile and run against in
-- F5: Use cf-tool to test
-- F8: Use cf-tool to submit
vim.api.nvim_buf_set_keymap(0, 'i', '<F1>', '<ESC> :w <CR> gg0vG$"+y :!g++ main.cpp && oj t', { noremap = true, silent = false})
vim.api.nvim_buf_set_keymap(0, 'n', '<F1>', '<ESC> :w <CR> gg0vG$"+y :!g++ main.cpp && oj t<CR>', { noremap = true, silent = false})
vim.api.nvim_buf_set_keymap(0, 'i', '<F3>', '<ESC> :w <CR> :!xclip -sel c -o > %:p:h/in%:r<CR> :!g++ -std=c++17 -Wall -Wextra -Wshadow -Wno-sign-conversion -DLOCAL -O2 -I/mnt/Data/Documents/problems/include % && ./a.out < ./in%:r<CR>', { noremap = true, silent = true})
vim.api.nvim_buf_set_keymap(0, 'n', '<F3>', '<ESC> :w <CR> :!xclip -sel c -o > %:p:h/in%:r<CR> :!g++ -std=c++17 -Wall -Wextra -Wshadow -Wno-sign-conversion -DLOCAL -O2 -I/mnt/Data/Documents/problems/include % && ./a.out < ./in%:r<CR>', { noremap = true, silent = true})
vim.api.nvim_buf_set_keymap(0, 'i', '<F4>', '<ESC> :w <CR> :!g++ -std=c++17 -Wall -Wextra -Wshadow -Wno-sign-conversion -DLOCAL -O2 -I/mnt/Data/Documents/problems/include % && ./a.out < ./in%:r<CR>', { noremap = true, silent = false})
vim.api.nvim_buf_set_keymap(0, 'n', '<F4>', '<ESC> :w <CR> :!g++ -std=c++17 -Wall -Wextra -Wshadow -Wno-sign-conversion -DLOCAL -O2 -I/mnt/Data/Documents/problems/include % && ./a.out < ./in%:r<CR>', { noremap = true, silent = false})
-- vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', '<ESC> :w <CR> :CFTest<CR>', { noremap = true, silent = false})
vim.api.nvim_buf_set_keymap(0, 'i', '<F5>', '<ESC> :w <CR> :!cf test %<cr>', { noremap = true, silent = false})
vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', '<ESC> :w <CR> :!cf test %<CR>', { noremap = true, silent = false})
vim.api.nvim_buf_set_keymap(0, 'n', '<F8>', '<ESC> :w <CR> :!cf submit -f % %:p:h:h:t %:p:h:t<CR>', { noremap = true, silent = false})
vim.api.nvim_buf_set_keymap(0, 'n', '<F8>', '<ESC> :w <CR> :!cf submit -f % %:p:h:h:t %:p:h:t<CR>', { noremap = true, silent = false})

-- Snippets
vim.api.nvim_buf_set_keymap(0, 'i', 'tt<tab>', 'int tt; cin >> tt;<ESC>owhile(tt--) {<ESC>o<CR>}<Up><tab>', { noremap = true, silent = false})
-- vim.api.nvim_buf_set_keymap(0, 'i', 'for<tab>', 'for(int i = 0; i < n; i++) {<ESC>o<CR>}<Up><tab>', { noremap = true, silent = false})
