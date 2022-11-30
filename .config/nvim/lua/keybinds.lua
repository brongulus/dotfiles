--Personl Keybinds
local map = vim.api.nvim_set_keymap

map('n', '<leader>r', ':luafile %<CR>', { noremap = true, silent = true })
map('n', '<leader>hrr', ':PackerSync<CR>', { noremap = true, silent = true})
map('i', 'jk', '<Esc>', { noremap = true, silent = true })
map('i', 'kj', '<Esc>', { noremap = true, silent = true })
map('n', '<leader>qq', ':qa<cr>', { noremap = true, silent = true })
-- map('n', '<Esc>', ':set hidden<cr> :e #<cr>', { noremap = true, silent = true })
map('n', ';', '<cmd>FineCmdline<CR>', { noremap = true, silent = true})
map('n', '<leader>fp', ':e ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true})
map('n', '<leader>fu', ':SudoWrite<CR>', { noremap = true, silent = true})
map('n', '<leader>y', '"+y', { noremap = true, silent = true })
map('v', '<leader>y', '"+y', { noremap = true, silent = true })
map('n', '<leader>p', '"+p', { noremap = true, silent = true })
map('i', '<C-e>', '<C-o>$', { noremap = true, silent = true})

--Windows
map('n', '<leader>wmm', '<C-w>o', { noremap = true, silent = true})
map('n', '<leader>ws', '<C-w>s<C-w>j', { noremap = true, silent = true})
map('n', '<leader>wv', '<C-w>v<C-w>l', { noremap = true, silent = true})
map('n', '<leader>wd', '<C-w>q', { noremap = true, silent = true})
map('n', '<S-left>', '<C-w>h', { noremap = true, silent = true})
map('n', '<S-down>', '<C-w>j', { noremap = true, silent = true})
map('n', '<S-up>', '<C-w>k', { noremap = true, silent = true})
map('n', '<S-right>', '<C-w>l', { noremap = true, silent = true})
map('n', '<S-f>', '<C-w><C-p>', { noremap = true, silent = true})

--Tabs
map('n', '<M->>', ':tabNext<cr>', { noremap = true, silent = true})
map('n', '<M-<>', ':tabprevious<cr>', { noremap = true, silent = true})
map('n', '<C-t>', ':tabnew<cr>', { noremap = true, silent = true})
map('n', '<C-w>', ':tabclose<cr>', { noremap = true, silent = true})

--COC
map('n', '<leader>op', ':CocCommand explorer<CR>', { noremap = true, silent = true })
-- map('i', '<cr>', 'coc#pum#visible() ? coc#pum#confirm() : "\<CR>"', { noremap = true, silent = true })
vim.cmd[[
"inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>cr <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction-cursor)

" Show all diagnostics.
nnoremap <silent><nowait> <leader>ca  :<C-u>CocList diagnostics<cr>
nmap <silent> gL <cmd>call coc#rpc#request('fillDiagnostics', [bufnr('%')])<CR><cmd>Trouble loclist<CR>`

" Show outline
nnoremap <silent><nowait> <space>si  :<C-u>CocList outline<cr>
]]

--Buffers
map('n', '<leader><left>', ':set hidden<CR> :bprevious<CR>', { noremap = true, silent = true})
map('n', '<leader><right>', ':set hidden<CR> :bnext<CR>', { noremap = true, silent = true})
map('n', '<leader>bd', ':b#<bar>bd#<CR>', { noremap = true, silent = true})
map('n', '<leader>bk', ':bd!<CR>', { noremap = true, silent = true})
map('n', '<leader>bs', ':w<CR>', { noremap = true, silent = true})
map('n', '<leader>fu', ':SudoWrite<CR>', { noremap = true, silent = true })

--Line Navigation
map('i', '<C-a>', '<Home>', { noremap = true, silent = true })
map('i', '<C-l>', '<End>', { noremap = true, silent = true })

-- Goyo
map('n', '<leader>tz', ':Goyo<CR>', { noremap = true, silent = true })

--FZFLUA
map('n', '<leader>fr', ':FzfLua oldfiles<cr>', { noremap = true, silent = true})
map('n', '<leader>.', ':FzfLua git_files<cr>', { noremap = true, silent = true})
map('n', '<leader><space>', ':FzfLua files<cr>', { noremap = true, silent = true})
map('n', '<leader>,', ':FzfLua buffers<cr>', { noremap = true, silent = true})
map('n', '<leader>sb', ':FzfLua blines<cr>', { noremap = true, silent = true})
map('n', '<leader>sp', ':FzfLua grep_project<cr>', { noremap = true, silent = true})
map('n', '<leader>;', ':FzfLua commands<cr>', { noremap = true, silent = true})
map('n', '<leader>x', ':FzfLua command_history<cr>', { noremap = true, silent = true})
map('n', '<leader>h', ':FzfLua help_tags<cr>', { noremap = true, silent = true})
map('n', '<leader>h\'', ':FzfLua highlights<cr>', { noremap = true, silent = true})
map('n', '<leader>hk', ':FzfLua keymaps<cr>', { noremap = true, silent = true })
map('n', '<leader>d', ':CocCommand explorer<cr>', {noremap = true, silent = true})
map('n', '<leader>gs', ':FzfLua git_status<cr>', { noremap = true, silent = true})
map('n', '<leader>gc', ':FzfLua git_commits<cr>', { noremap = true, silent = true})
map('n', '<leader>gb', ':FzfLua git_branches<cr>', { noremap = true, silent = true})

--Telescope
--Add leader shortcuts
--vim.api.nvim_set_keymap('n', '<leader>t', [[<cmd>lua require('telescope.builtin').tags()<cr>]], { noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], { noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<leader>o', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<cr>]], { noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], { noremap = true, silent = true})

--  -- Mappings.
--  local opts = { noremap=true, silent=true }
--  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
--  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
--end

