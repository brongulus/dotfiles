--Personl Keybinds
local map = vim.api.nvim_set_keymap

map('n', '<leader>r', ':luafile %<CR>', { noremap = true, silent = true })
map('n', '<leader>hrr', ':PackerSync<CR>', { noremap = true, silent = true})
map('i', 'jk', '<Esc>', { noremap = true, silent = true })
map('i', 'kj', '<Esc>', { noremap = true, silent = true })
map('n', '<leader>qq', ':qa<cr>', { noremap = true, silent = true })
-- map('n', '<Esc>', ':set hidden<cr> :e #<cr>', { noremap = true, silent = true })
map('n', '<Esc>x', '<cmd>FineCmdline<CR>', { noremap = true, silent = true})
map('n', ';', '<cmd>FineCmdline<CR>', { noremap = true, silent = true})
map('n', '<leader>fp', ':e ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true})
map('n', '<leader>fu', ':SudoWrite<CR>', { noremap = true, silent = true})
map('n', '<leader>y', '"+y', { noremap = true, silent = true })
map('v', '<leader>y', '"+y', { noremap = true, silent = true })
map('n', '<leader>p', '"+p', { noremap = true, silent = true })
map('i', '<C-e>', '<C-o>$', { noremap = true, silent = true})
map('n', ':Q', ':q', { noremap = true, silent = true })
map('n', ':W', ':w', { noremap = true, silent = true })

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
map('n', ',,', '<c-^>', { noremap = true, silent = true})

--Tabs
map('n', '<leader>j', ':tabNext<cr>', { noremap = true, silent = true})
map('n', '<leader>k', ':tabprevious<cr>', { noremap = true, silent = true})
map('n', '<C-t>', ':tabnew<cr>', { noremap = true, silent = true})
map('n', '<C-w>', ':tabclose<cr>', { noremap = true, silent = true})

--COC
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
map("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
map("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
map("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
-- Use <c-j> to trigger snippets
map("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)", {silent = true})
-- Use <c-space> to trigger completion
map("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})
-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
map("n", "<leader>ca", ":<C-u>CocList diagnostics<cr>", {silent = true})
map("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
map("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
-- GoTo code navigation
map("n", "gd", "<Plug>(coc-definition)", {silent = true})
map("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
map("n", "gi", "<Plug>(coc-implementation)", {silent = true})
map("n", "gr", "<Plug>(coc-references)", {silent = true})
-- Code Actions
map("n", "<leader>cr", "<Plug>(coc-rename)", {silent = true})
map("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", {silent = true})
map("n", "<leader>si", ":<C-u>CocList outline<cr>", {silent = true})
-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
map("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

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

