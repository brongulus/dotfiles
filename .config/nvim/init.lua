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
\ 'coc-pairs',
\ 'coc-clangd',
\ 'coc-zig',
\ 'coc-pyright',
\ 'coc-rust-analyzer',
\ 'coc-tsserver',
\ 'coc-snippets',
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
	augroup CFTemplate
		autocmd!
    autocmd BufNewFile */problems/*.py silent! 0r ~/.config/nvim/template.py
    autocmd BufNewFile */problems/*.py silent! :normal 7ji
		autocmd BufNewFile */Codeforces/*.cpp silent! 0r ~/.config/nvim/base.cpp 
		autocmd BufNewFile */Codeforces/*.cpp silent! 3$pu=strftime('%d-%m-%Y %H:%M:%S')
		autocmd BufNewFile */Codeforces/*.cpp silent! :normal kJ15ja
		autocmd BufNewFile */atcoder/*.cpp silent! 0r ~/.config/nvim/base.cpp 
		autocmd BufNewFile */atcoder/*.cpp silent! 3$pu=strftime('%d-%m-%Y %H:%M:%S')
		autocmd BufNewFile */atcoder/*.cpp silent! :normal kJ15ja
		autocmd BufNewFile */google/*.cpp silent! 0r ~/.config/nvim/base.cpp 
		autocmd BufNewFile */google/*.cpp silent! 3$pu=strftime('%d-%m-%Y %H:%M:%S')
		autocmd BufNewFile */google/*.cpp silent! :normal kJ15ja
    "autocmd BufNewFile */usaco_training/*.cpp silent! :normal iusaco
    "autocmd BufNewFile */usaco_training/*.cpp execute "normal $<Plug>(coc-snippets-expand)<CR>"
	augroup end
]]

-- Legend
-- F2: Save file
-- F9: Copy current buffer into clipboard
-- F10: Close buffer
-- F12: List open buffers

vim.api.nvim_set_keymap('i', '<F2>', '<ESC> :w <CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F2>', ':w <CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F9>', '<ESC> :w <CR> gg0vG$"+y', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<F9>', '<ESC> :w <CR> gg0vG$"+y', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F10>', 'bufname() == "" ? ":q<CR>" : ":lua buf_kill(0)<CR>"', { noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap('n', '<F12>', ':FzfLua buffers<cr>', { noremap = true, silent = true})

---------------------------
-- Improved find
vim.cmd[[
" :find
set path=**
" set suffixesadd=.java,.py
" :find gets better more
set nocompatible
set wildmode=full
set wildmenu
set wildignore=*.out,*.exe
]]


-- R stuff
vim.cmd[[
let R_app = "radian"
let R_cmd = "R"
let R_hl_term = 0
let R_args = []  " if you had set any
let R_bracketed_paste = 1
]] 

---------------------------

-- COC config
-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300
-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"
-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

vim.api.nvim_set_keymap('n', '<leader>>', 'o<C-r>=strftime("%F %H:%M ")<CR>', { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>ot', '<C-w>s<C-w>j :cd %:p:h<CR> :terminal<CR>i', { noremap = true, silent = true})

vim.cmd[[
autocmd! BufRead,BufNewFile *.pypy3 silent! set ft=python
"autocmd! BufNewFile,BufRead *.hlsl silent! set ft=glsl
set rtp^=~/.config/nvim/hlsl.vim
autocmd BufRead,BufNewFile *.fx,*.fxc,*.fxh,*.hlsl setfiletype hlsl
autocmd BufEnter term://* startinsert
set go+=!
]]

-- All space is good space
vim.opt.cmdheight = 0

-- Org Mode
require('orgmode').setup_ts_grammar()

require'nvim-treesitter.configs'.setup {
	ensure_installed = {"bash", "c", "comment", "cpp", "java", "lua", "python", "regex", "org"},
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'},
	indent = {
		enable = true,
	}
}
require('orgmode').setup({
  org_agenda_files = {'/mnt/manjaro/home/prashant/Dropbox/org/*'},
  org_default_notes_file = '/mnt/manjaro/home/prashant/Dropbox/org/notes.org',
})

-- Line Numbers
-- vim.wo.relativenumber = true
-- vim.wo.number = true

-- Mouse support 
vim.cmd[[set mouse=a]]

-- Auto cd
vim.cmd [[
set autochdir
au VimEnter * cd %:p:h
]]


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
		autocmd TextYankPost * silent! lua vim.highlight.on_yank{ timeout = 250, higroup = "Visual" }
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
-- vim.cmd 'colorscheme material'

require('fine-cmdline').setup({
  popup = {
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:Border',
    },
  }
})

vim.cmd[[
" au ColorScheme * hi Comment cterm=italic gui=italic
au InsertEnter * hi StatusLine ctermfg=Yellow guibg=#EBCB8B guifg=#25363B
au TermEnter * hi StatusLine ctermfg=Green guibg=#A3BE8C guifg=#25363B
au TextChangedI * hi StatusLine ctermfg=Red guibg=#D57780 guifg=#25363B
au BufRead,BufWrite,InsertLeave,TermLeave * hi StatusLine ctermfg=NONE ctermbg=NONE ctermfg=NONE guibg=#81A1C1 guifg=#25363B
]]

vim.cmd[[
function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E:' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W:' . info['warning'])
  endif
  return join(msgs, ' ') . ' |' . get(g:, 'coc_status', '')
endfunction

set statusline=\ %{v:lua.require'nvim-web-devicons'.get_icon_by_filetype(&filetype)}\ 
set statusline+=%{expand('%:p:h:t')}\/
set statusline+=%f\ %h%w%m%r\ 
set statusline+=%=%(%{StatusDiagnostic()}\ %l\ %=\ %P%)\ 
"set statusline+=%=%(%{coc#status()}%{get(b:,'coc_current_function','')}\ \ %l\ %=\ %P%)\ 
"set statusline+=%=%(%l\ %=\ %P%)\ 
]]

-- Notify
vim.notify = require("notify")
vim.notify.setup({
  background_colour = "#000",
})
vim.cmd[[
lua << EOF

local coc_status_record = {}

function coc_status_notify(msg, level)
  local notify_opts = { title = "LSP Status", timeout = 500, hide_from_history = true, on_close = reset_coc_status_record }
  -- if coc_status_record is not {} then add it to notify_opts to key called "replace"
  if coc_status_record ~= {} then
    notify_opts["replace"] = coc_status_record.id
  end
  coc_status_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_status_record(window)
  coc_status_record = {}
end

local coc_diag_record = {}

function coc_diag_notify(msg, level)
  local notify_opts = { title = "LSP Diagnostics", timeout = 500, on_close = reset_coc_diag_record }
  -- if coc_diag_record is not {} then add it to notify_opts to key called "replace"
  if coc_diag_record ~= {} then
    notify_opts["replace"] = coc_diag_record.id
  end
  coc_diag_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_diag_record(window)
  coc_diag_record = {}
end
EOF

function! s:DiagnosticNotify() abort
  let l:info = get(b:, 'coc_diagnostic_info', {})
  if empty(l:info) | return '' | endif
  let l:msgs = []
  let l:level = 'info'
   if get(l:info, 'warning', 0)
    let l:level = 'warn'
  endif
  if get(l:info, 'error', 0)
    let l:level = 'error'
  endif
 
  if get(l:info, 'error', 0)
    call add(l:msgs, ' Errors: ' . l:info['error'])
  endif
  if get(l:info, 'warning', 0)
    call add(l:msgs, ' Warnings: ' . l:info['warning'])
  endif
  if get(l:info, 'information', 0)
    call add(l:msgs, ' Infos: ' . l:info['information'])
  endif
  if get(l:info, 'hint', 0)
    call add(l:msgs, ' Hints: ' . l:info['hint'])
  endif
  let l:msg = join(l:msgs, "\n")
  if empty(l:msg) | let l:msg = ' All OK' | endif
  call v:lua.coc_diag_notify(l:msg, l:level)
endfunction

function! s:StatusNotify() abort
  let l:status = get(g:, 'coc_status', '')
  let l:level = 'info'
  if empty(l:status) | return '' | endif
  call v:lua.coc_status_notify(l:status, l:level)
endfunction

function! s:InitCoc() abort
  execute "lua vim.notify('Initialized coc.nvim for LSP support', 'info', { title = 'LSP Status' })"
endfunction

" notifications
"autocmd User CocNvimInit call s:InitCoc()
"autocmd User CocDiagnosticChange call s:DiagnosticNotify()
"autocmd User CocStatusChange call s:StatusNotify()
]]

-- Tabline
require("bufferline").setup{
	options = {
		mode = "tabs",
		diagnostics = "coc",
		show_buffer_icons = true,
  }
}

local colors = require("onenord.colors").load()
require('onenord').setup({
  styles = {
    comments = "italic",
    strings = "italic",
  },
  disable = {
    background = true,
    eob_lines = false,
  },
  custom_highlights = {
    StatusLine = { fg = colors.bg, bg = colors.blue },
    CocFloating = { bg = colors.bg },
  },
})
vim.cmd 'colorscheme onenord'

-- Neovide
if vim.g.neovide then
  vim.g.neovide_transparency = 0.9
  vim.opt.guifont = { "Victor Mono", "h15" }
  vim.g.neovide_cursor_animation_length = 0
  
  vim.keymap.set('n', '<C-S-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<C-S-c>', '"+y') -- Copy
  vim.keymap.set('n', '<C-S-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<C-S-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<C-S-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<C-S-v>', '<ESC>l"+Pli') -- Paste insert mode
end

-- Rainbow mode
require'colorizer'.setup()

-- %< - where to truncate the line if too long
-- %f - buffer name (path to a file, or something)
-- %h, %m, %r - help, modified, readonly flag
-- %= - separater between the left (buffer name) and the right (ruler) parts
-- %-14.(...%) - minimum field width == 14
-- %l, %c, %V, %P - line, column, virtual column, percentage
