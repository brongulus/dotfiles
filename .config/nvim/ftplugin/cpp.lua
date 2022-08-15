vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	pattern = {"*.cpp", "*.h"},
	command = ":normal gg017ja",
})
