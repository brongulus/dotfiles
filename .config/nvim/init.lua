--Bookmarks

vim.opt.termguicolors = true

-- Install packer
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

-- Load Packages
require('pkgs')

-- NOTE: Remember to run :CocInstall (coc-explorer, coc-clang, coc-zig, coc-pyright, coc-rust-analyzer)
vim.cmd[[
let g:coc_global_extensions = [
  \ 'coc-explorer',
  \ 'coc-clangd',
  \ 'coc-zig',
  \ 'coc-pyright',
  \ 'coc-rust-analyzer',
  \ '...'
  \ ]
]]


--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load Keybindings( Tidy Config :)
-- FIXME require('plenary.reload').reload_module('eybinds')
require('keybinds')

--Clipboard
-- vim.api.nvim_exec([[set clipboard unnamedplus]])

-- Enable filetype.lua
-- vim.g.do_filetype_lua = 1
vim.cmd[[
autocmd! BufNewFile,BufRead *.cc,*.j2 silent! set ft=cpp
]]



-- Comp Setup ---------------------------------

-- Template for new cpp files 
vim.cmd [[ 
	augroup Template
		autocmd!
		autocmd BufNewFile *.cpp silent! 0r ~/.config/nvim/base.cpp 
		autocmd BufNewFile *.cpp silent! 3$pu=strftime('%d-%m-%Y %H:%M:%S')
		autocmd BufNewFile *.cpp silent! :normal kJ15ja
	augroup end
]]

-- Legend
-- F1: Save, copy entire text and test using oj
-- F2: Save file
-- F3: Compile file and run against in
-- F4: Paste clipboard content into a file called in
-- S-F4: Create a file
-- F8: Delete a file
-- F9: Compile and run
-- F10: Close buffer
-- F12: List open buffers

vim.api.nvim_set_keymap('i', '<F1>', '<ESC> :w <CR> gg0vG"+y :!g++ main.cpp && oj t', { noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<F1>', '<ESC> :w <CR> gg0vG"+y :!g++ main.cpp && oj t<CR>', { noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<F2>', ':w<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<F2>', '<ESC> :w<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F3>', '<ESC> :w <CR> :!g++ -std=c++17 -Wall -Wextra -Wshadow -O2 -o %< % && ./%< < in<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-F4>', ':edit ', { noremap = true, silent = false})
vim.api.nvim_set_keymap('i', '<S-F4>', '<ESC> :edit ', { noremap = true, silent = false})
-- FIXME save (potentially save, close and run g++)
-- vim.api.nvim_set_keymap('n', '<F4>', ':edit in <CR>:normal "+p <CR> :w<CR>', { noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<F4>', '<ESC> :w <CR> :!xclip -selection c -o > in<CR>', { noremap = true, silent = false})
vim.api.nvim_set_keymap('i', '<F4>', '<ESC> :w <CR> :!xclip -selection c -o > in<CR>', { noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<F8>', ':!rm % <CR> :bd!<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F9>', '<ESC> :w <CR> :!g++ -std=c++17 -Wall -Wextra -Wshadow -O2 -o %< % && ./%< <CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<F9>', '<ESC> :w <CR> :!g++ -std=c++17 -Wall -Wextra -Wshadow -O2 -o %< % && ./%< <CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F10>', 'bufname() == "" ? ":q<CR>" : ":bd!<CR>"', { noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap('n', '<F12>', ':FzfLua buffers<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '[', ':bp <CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', ']', ':bn <CR>', { noremap = true, silent = true})


---------------------------

vim.api.nvim_set_keymap('n', '<leader>>', 'o<C-r>=strftime("%F %H:%M ")<CR>', { noremap = true, silent = true})

--Terminal
require("toggleterm").setup{
	direction = float,
	float_opts = {
	border = 'curved',
	}
}
vim.api.nvim_set_keymap('n', '<leader>ot', ':ToggleTerm<CR>', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>ot', '<C-w>s :cd %:p:h<CR> :terminal<CR>i', { noremap = true, silent = true})

-- Nightly
-- vim.opt.cmdheight = 0 -- status line smaller


-- Org Mode
require('orgmode').setup_ts_grammar()

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = {'/mnt/manjaro/home/prashant/Dropbox/org/*'},
  org_default_notes_file = '/mnt/manjaro/home/prashant/Dropbox/org/notes.org',
})

-- Rainbow mode
require'colorizer'.setup()

-- Line Numbers
vim.wo.relativenumber = true
vim.wo.number = true

-- FIXME Auto cd
vim.cmd [[set autochdir]]

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- FIXME Change preview window location
vim.g.splitbelow = true

--Centred Cursor
vim.o.scrolloff=15

--Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

--Add move line shortcuts
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-j>', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-k>', ':m \'<-2<CR>gv=gv', { noremap = true, silent = true})

--Neogit
vim.api.nvim_set_keymap('n', '<leader>gg', ':cd %:p:h<CR> :Neogit<CR>', { noremap = true, silent = true })

--Vimtex
vim.g.tex_flavor='latex'
vim.g.vimtex_compiler_method = 'tectonic'
vim.g.vimtex_view_method='zathura'
vim.g.vimtex_quickfix_mode=2
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'
vim.g.tex_conceal='abdmg'

-- vim.g.onedark_terminal_italics = 2

-- Highlight on yank
vim.cmd [[
	augroup YankHighlight
		autocmd!
		autocmd TextYankPost * silent! lua vim.highlight.on_yank()
	augroup end
]]

-- Treesitter
require'nvim-treesitter.configs'.setup {
	ensure_installed = {"bash", "c", "comment", "cpp", "java", "lua", "python", "regex", },
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	}
}

-- Statusline and Colors
local colors = require("onenord.colors").load()
require('onenord').setup({
  disable = {
    background = true,
  },
  custom_highlights = {
    StatusLine = { fg = colors.bg, bg = colors.blue },
  },
})
-- require "colorscheme".init()

require('fine-cmdline').setup({
  popup = {
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:Border',
    },
  }
})

vim.cmd[[
au InsertEnter * hi StatusLine ctermfg=Yellow guibg=#EBCB8B
au TermEnter * hi StatusLine ctermfg=Green guibg=#A3BE8C
au TextChangedI * hi StatusLine ctermfg=Red guibg=#D57780
au BufRead,BufWrite,InsertLeave,TermLeave * hi StatusLine ctermfg=Cyan guibg=#88C0D0
]]

vim.cmd[[
set statusline=\ %{v:lua.require'nvim-web-devicons'.get_icon_by_filetype(&filetype)}\ 
set statusline+=%f\ %h%w%m%r\ 
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
"set statusline+=%{coc#status()}
set statusline+=%=%(%l\ %=\ %P%)\ 
]]

-- %< - where to truncate the line if too long
-- %f - buffer name (path to a file, or something)
-- %h, %m, %r - help, modified, readonly flag
-- %= - separater between the left (buffer name) and the right (ruler) parts
-- %-14.(...%) - minimum field width == 14
-- %l, %c, %V, %P - line, column, virtual column, percentage
