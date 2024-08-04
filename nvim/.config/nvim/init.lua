local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.opt.termguicolors = true

require("lazy").setup({
  { "folke/tokyonight.nvim", opts = { transparent = true, } },
   -- "JoosepAlviste/palenightfall.nvim",
  "nvim-tree/nvim-web-devicons",
  { "prichrd/netrw.nvim", config = true },
  { "tpope/vim-fugitive", cmd = {'Gclog', 'G'}},
  { "tpope/vim-projectionist" },
  { 'numToStr/Comment.nvim', config = true, lazy = false, },
  { "sindrets/diffview.nvim", cmd = { 'DiffviewFileHistory', 'DiffviewOpen' },
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        key_bindings = {
          file_history_panel = { q = '<Cmd>DiffviewClose<CR>' },
          file_panel = { q = '<Cmd>DiffviewClose<CR>' },
          view = { q = '<Cmd>DiffviewClose<CR>' },
        },
        file_panel = {
          listing_style = "list",
          win_config = function()
            local editor_width = vim.o.columns
            return { position = "bottom", height = 16, } -- width = editor_width >= 247 and 45 or 35, }
          end,
        },
      })
    end
  },
  { "lewis6991/gitsigns.nvim", config = true },
  { "lewis6991/satellite.nvim", config = true, enabled = false }, -- 0.10+
  { 'akinsho/git-conflict.nvim', version = "*", config = true },
  { "b0o/incline.nvim", config = true },
  "chrisbra/NrrwRgn",
  { "nvimdev/indentmini.nvim", event = 'BufEnter', enabled = true,
    config = function()
      require("indentmini").setup({ char = "│", })
      vim.cmd.highlight("default link IndentLine LineNr")
    end,
  },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "nvim-pack/nvim-spectre", lazy = true, dependencies = "nvim-lua/plenary.nvim" },
  { "ibhagwan/smartyank.nvim", opts = { highlight = { timeout = 200 } }, },
  { "junegunn/fzf", build = "./install --bin" },
  { "ibhagwan/fzf-lua", lazy = true,
    config = function() 
      require("fzf-lua").setup({
        'max-perf',
        winopts = { 
          on_create = function()
            vim.api.nvim_buf_set_keymap(0, "t", "<tab>", "<down>", { noremap = true })
            vim.api.nvim_buf_set_keymap(0, "t", "<S-tab>", "<up>", { noremap = true })
          end
        },
        fzf_colors = { 
          ["bg+"] = { "bg", "Normal"}, 
          ["gutter"] = { "bg", "Normal"}, 
        },
      }) 
    end 
  },
  { "nvimdev/guard.nvim",
    config = function()
      local ft = require('guard.filetype')
      ft('c,h,cpp'):fmt({
        cmd = "clang-format",
        args = { "--style={BasedOnStyle: Google, AllowShortLoopsOnASingleLine: true, AllowShortBlocksOnASingleLine: true, AllowShortFunctionsOnASingleLine: All, IndentWidth: 2, TabWidth: 2, SortIncludes: false, ColumnLimit: 500}" },
        stdin = true,
        ignore_patterns = { "**/param.j2" },
      })
      require("guard").setup({ fmt_on_save = true, lsp_as_default_formatter = false })
    end
  },
  { "nvim-treesitter/nvim-treesitter", event = "VeryLazy", build = ":TSUpdate",
    config = function () 
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vimdoc", "c", "cpp", "python", "bash", "cmake", "fish" },
        sync_install = false, highlight = { enable = true }, indent = { enable = true },  
        incremental_selection = {
          enable = true, keymaps = { init_selection = '+', node_incremental = '+', node_decremental = '-', }, 
        },
      })
    end
  },
  { "williamboman/mason.nvim", 
    config = function ()
      require('mason').setup()
    end
  },
  { "williamboman/mason-lspconfig.nvim",
    config = function ()
      require('mason-lspconfig').setup({
        ensure_installed = { "clangd", "pyright", "cmake" },
        automatic_installation = true,
      })
    end
  },
  { "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").pyright.setup{}
      require("lspconfig").cmake.setup{}
      require("lspconfig").clangd.setup{
        cmd = { "clangd" }
      }
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end
  },
  { 'nvimdev/lspsaga.nvim', event = 'LspAttach', opts = { lightbulb = { sign = false,} }, },
  { "hrsh7th/nvim-cmp", event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lua", "onsails/lspkind-nvim",
    },
    config = function()
      vim.opt.pumheight = 12
      local cmp = require("cmp")
      require('cmp').setup({
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        formatting = {
          format = require('lspkind').cmp_format({ with_text = false, maxwidth = 50 }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          -- { name = "nvim_lua" },
          { name = "path" },
        },
        mapping = {
          -- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          -- ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
      })
    end
  },
  { "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    opts = {
      options = { theme = 'tokyonight', }, -- palenight 
      sections = { 
        lualine_c = { { 'filename', path = 1, } },
        lualine_x = { 'searchcount', 'filetype' }, lualine_b = { { 'branch', icon = '' }, 'diff', 'diagnostics' } },
    }
  },
  {'akinsho/bufferline.nvim', version = "*", event = "VeryLazy", 
    opts = { options = { always_show_bufferline = false, mode = "tabs", } } 
  },
  diff = { cmd = "diffview.nvim", },
})

vim.cmd[[
set t_TI=^[[4?h
set t_TE=^[[4?l

nnoremap ; :
inoremap jk <esc>
inoremap ` <esc> " oneplusPad
" assumes set ignorecase smartcase
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END
" ----- Netrw ----- "
nnoremap <silent> - <cmd>silent Explore %:p:h<cr>
nnoremap <silent> <C-b> <cmd>Lexplore %:p:h<cr>
let g:netrw_localcopydircmd='cp -r'
let g:netrw_banner=0
let g:netrw_silent=1
if &columns < 90
  let g:netrw_winsize = 50
else
  let g:netrw_winsize = 30
endif
function NetrwMappings()
  nnoremap <buffer> q <cmd>bd<cr>
endfunction
autocmd! filetype netrw call NetrwMappings()
" ----------------- "
cnoremap Q q
cnoremap W w
nnoremap Q <Nop>
nnoremap <tab> ==
"vnoremap <leader>y "+y
"vnoremap <leader>ty :call system("tmux load-buffer -", @0)<cr>gv
"nnoremap <leader>p :let @0 = system("tmux save-buffer -")<cr>"0p<cr>g;
autocmd TermOpen * setlocal nonumber norelativenumber
autocmd Filetype python setlocal ts=2 sw=2 softtabstop=2 expandtab
autocmd! BufRead,BufNewFile *.bin silent! :%!xxd
autocmd! BufNewFile,BufRead *.j2 silent! set ft=cpp
autocmd! BufNewFile,BufRead *.tie silent! set ft=verilog
set number
set relativenumber
set backspace=indent,eol,start
set nofixeol
set nofixendofline
set shortmess-=S
set nowrap

colorscheme tokyonight-moon "palenightfall
set fillchars+=diff:\  "diffview
set diffopt+=iwhiteall,iblank
set diffexpr=""
set laststatus=3 "incline
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
" persistent undo: ensure the directory is present
set undofile
set undodir=~/.vim-undo
]]

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local map,opts = vim.keymap.set,{ noremap = true, silent = true }
map('n', '<leader>t', '<cmd>tabnew<CR>' )
map('n', '<leader>r', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>' )
map('n', '<leader>d', '<cmd>DiffviewOpen<CR>' )
map('n', '<leader>gc', '<cmd>DiffviewOpen origin/master...HEAD --imply-local<CR>' )
map('n', '<leader>gk', '<cmd>DiffviewOpen origin/master...HEAD --imply-local -- **/kernel.cc<CR>' )
map('n', '<leader><space>', '<cmd>lua require("fzf-lua")<CR><cmd>FzfLua<CR>' )
map('n', '<leader>sp', '<cmd>lua require("fzf-lua")<CR><cmd>FzfLua grep_project<CR>' )
map('n', '<leader>o', '<cmd>lua require("fzf-lua")<CR><cmd>FzfLua git_files<CR>' )
map('n', '<leader>gs', '<cmd>lua require("fzf-lua")<CR><cmd>FzfLua git_status<CR>' )
map('n', '<leader>fp', '<cmd>e ~/.config/nvim/init.lua<CR>', opts)
map('n', '<leader>tw', '<cmd>set wrap!<CR>', opts)
map('n', '<leader>qq', '<cmd>qa<CR>', opts)
map('i', '<C-e>', '<C-o>$', opts)
map('i', '<C-a>', '<C-o>_', opts)
map('i', '<C-n>', '<C-o>j', opts)
map('i', '<C-p>', '<C-o>k', opts)

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.bo.softtabstop = 2
vim.opt.cmdheight = 0
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

command("DiffviewCommit", function (args)
  vim.cmd("DiffviewOpen " .. args['args'] .. "~1..." .. args['args'] .. " --imply-local")
end, { nargs = 1 })
