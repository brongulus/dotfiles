--Bookmarks
-- netRW supports, mb and gb, qb

vim.opt.termguicolors = true
vim.wo.wrap = false

-- Install packer
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

-- Load Packages
require('pkgs')

-- Install coc language servers
vim.cmd[[
let g:coc_global_extensions = [
\ 'coc-explorer',
\ 'coc-clangd',
\ 'coc-zig',
\ 'coc-pyright',
\ 'coc-rust-analyzer',
\ ]
]]

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load Keybindings( Tidy Config :)
-- FIXME: require('plenary.reload').reload_module('eybinds')
require('keybinds')

-- Cleaner gitgutters
vim.cmd[[
set fillchars+=diff:╱
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_removed = '│'
let g:gitgutter_sign_removed_first_line = '│'
let g:gitgutter_sign_removed_above_and_below = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_modified_removed = '│'
]]

-- Kill buffer function for human use
-- (https://github.com/neovim/neovim/issues/2434#issuecomment-565577489)
local api = vim.api

local function nvim_loaded_buffers()
  local result = {}
  local buffers = api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if api.nvim_buf_is_loaded(buf) then
      table.insert(result, buf)
    end
  end
  return result
end

-- Kill the target buffer (or the current one if 0/nil)
function buf_kill(target_buf, should_force)
  if not should_force and vim.bo.modified then
    return api.nvim_err_writeln('Buffer is modified. Force required.')
  end
  local command = 'bd'
  if should_force then command = command..'!' end
  if target_buf == 0 or target_buf == nil then
    target_buf = api.nvim_get_current_buf()
  end
  local buffers = nvim_loaded_buffers()
  if #buffers == 1 then
    api.nvim_command(command)
    return
  end
  local nextbuf
  for i, buf in ipairs(buffers) do
    if buf == target_buf then
      nextbuf = buffers[(i - 1 + 1) % #buffers + 1]
      break
    end
  end
  api.nvim_set_current_buf(nextbuf)
  api.nvim_command(table.concat({command, target_buf}, ' '))
end

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
-- F3: Paste clipboard content & compile file & run against in
-- F4: Compile and run against in
-- F9: Copy current buffer into clipboard
-- F10: Close buffer
-- F12: List open buffers

vim.api.nvim_set_keymap('i', '<F1>', '<ESC> :w <CR> gg0vG$"+y :!g++ main.cpp && oj t', { noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<F1>', '<ESC> :w <CR> gg0vG$"+y :!g++ main.cpp && oj t<CR>', { noremap = true, silent = false})
vim.api.nvim_set_keymap('i', '<F2>', '<ESC> :w <CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F2>', ':w <CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<F3>', '<ESC> :w <CR> :!xclip -sel c -o > %:p:h/in<CR> :!g++ -std=c++17 -Wall -Wextra -Wshadow -DLOCAL -O2 -I/mnt/Data/Documents/problems/include % && ./a.out < ./in<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F3>', '<ESC> :w <CR> :!xclip -sel c -o > %:p:h/in<CR> :!g++ -std=c++17 -Wall -Wextra -Wshadow -DLOCAL -O2 -I/mnt/Data/Documents/problems/include % && ./a.out < ./in<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<F4>', '<ESC> :w <CR> :!g++ -std=c++17 -Wall -Wextra -Wshadow -DLOCAL -O2 -I/mnt/Data/Documents/problems/include % && ./a.out < ./in<CR>', { noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<F4>', '<ESC> :w <CR> :!g++ -std=c++17 -Wall -Wextra -Wshadow -DLOCAL -O2 -I/mnt/Data/Documents/problems/include % && ./a.out < ./in<CR>', { noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<F9>', '<ESC> :w <CR> gg0vG$"+y', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<F9>', '<ESC> :w <CR> gg0vG$"+y', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F10>', 'bufname() == "" ? ":q<CR>" : ":lua buf_kill(0)<CR>"', { noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap('n', '<F12>', ':FzfLua buffers<cr>', { noremap = true, silent = true})

---------------------------
-- R stuff
vim.cmd[[
let R_app = "radian"
let R_cmd = "R"
let R_hl_term = 0
let R_args = []  " if you had set any
let R_bracketed_paste = 1
]] 

---------------------------

vim.api.nvim_set_keymap('n', '<leader>>', 'o<C-r>=strftime("%F %H:%M ")<CR>', { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>ot', '<C-w>s<C-w>j :cd %:p:h<CR> :terminal<CR>i', { noremap = true, silent = true})

-- All space is good space
vim.opt.cmdheight = 0

-- Org Mode
require('orgmode').setup_ts_grammar()

require'nvim-treesitter.configs'.setup {
	ensure_installed = {"bash", "c", "comment", "cpp", "java", "lua", "python", "regex", "org"},
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
	indent = {
		enable = true,
	}
}

require('orgmode').setup({
  org_agenda_files = {'/mnt/manjaro/home/prashant/Dropbox/org/*'},
  org_default_notes_file = '/mnt/manjaro/home/prashant/Dropbox/org/notes.org',
})

-- Line Numbers
vim.wo.relativenumber = true
vim.wo.number = true

-- Mouse support 
vim.cmd[[set mouse=a]]

-- Auto cd
vim.cmd [[set autochdir]]

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- FIXME: Change preview window location
vim.g.splitbelow = true

--Centred Cursor
vim.o.scrolloff = 15
require('neoscroll').setup()

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

--Vimtex vim.g.tex_flavor='latex'
vim.g.vimtex_compiler_method = 'tectonic'
vim.g.vimtex_view_method='zathura'
vim.g.vimtex_quickfix_mode=2
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'
vim.g.tex_conceal='abdmg'

-- Highlight on yank
vim.cmd [[
	augroup YankHighlight
		autocmd!
		autocmd TextYankPost * silent! lua vim.highlight.on_yank()
	augroup end
]]

-- Close terminal on successful exit (tampers with fzflua)
-- vim.cmd[[
-- autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif
-- ]]

-- Statusline and Colors
local colors = require('material.colors')
vim.g.material_style = "oceanic"
require('material').setup({
	contrast = {
		cursor_line = true,
	},
	styles = { 
		comments = { italic = true },
		functions = { italic = true }
	},
  disable = {
    background = true,
  },
	plugins = {
		"neogit",
	},
  custom_highlights = {
		StatusLineNC = {bg = colors.editor.bg_alt },
    GitGutterChange = { fg = colors.main.darkblue },
    GitGutterAdd = { fg = colors.main.darkgreen },
    GitGutterDelete = { fg = colors.main.darkred },
		DiagnosticHint = { fg = colors.editor.line_numbers },
    CocMenuSel = { bg = colors.editor.link, fg = colors.editor.bg }
  },
  custom_colors = function(colors)
    colors.editor.cursor = colors.main.yellow
  end
})
vim.cmd 'colorscheme material'
-- local colors = require("onenord.colors").load()
-- require('onenord').setup({
--   styles = {
--     comments = "italic",
--     strings = "italic",
--   },
--   disable = {
--     background = true,
--     eob_lines = false,
--k  },
--   custom_highlights = {
--     StatusLine = { fg = colors.bg, bg = colors.blue },
--   },
-- })

require('fine-cmdline').setup({
  popup = {
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:Border',
    },
  }
})

vim.cmd[[
au ColorScheme * hi Comment cterm=italic gui=italic
au InsertEnter * hi StatusLine ctermfg=Yellow guibg=#EBCB8B guifg=#25363B
au TermEnter * hi StatusLine ctermfg=Green guibg=#A3BE8C guifg=#25363B
au TextChangedI * hi StatusLine ctermfg=Red guibg=#D57780 guifg=#25363B
au BufRead,BufWrite,InsertLeave,TermLeave * hi StatusLine ctermfg=NONE ctermbg=NONE ctermfg=NONE guibg=#314549 guifg=#B0BEC5
]]

vim.cmd[[
set statusline=\ %{v:lua.require'nvim-web-devicons'.get_icon_by_filetype(&filetype)}\ 
set statusline+=%f\ %h%w%m%r\ 
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
"set statusline+=%{coc#status()}
set statusline+=%=%(%l\ %=\ %P%)\ 
]]


-- Rainbow mode
require'colorizer'.setup()

-- %< - where to truncate the line if too long
-- %f - buffer name (path to a file, or something)
-- %h, %m, %r - help, modified, readonly flag
-- %= - separater between the left (buffer name) and the right (ruler) parts
-- %-14.(...%) - minimum field width == 14
-- %l, %c, %V, %P - line, column, virtual column, percentage
