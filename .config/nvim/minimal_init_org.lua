vim.cmd [[set runtimepath=$VIMRUNTIME]]
vim.cmd [[set packpath=/tmp/nvim/site]]

local package_root = '/tmp/nvim/site/pack'
local install_path = package_root .. '/packer/start/packer.nvim'

local function load_plugins()
  require('packer').startup {
    {
      'wbthomason/packer.nvim',
      {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
      {'kristijanhusak/orgmode.nvim', branch = 'master' },
    },
    config = {
      package_root = package_root,
      compile_path = install_path .. '/plugin/packer_compiled.lua',
    },
  }
end

_G.load_config = function()
  require('nvim-treesitter.configs').setup({})

  local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

  parser_config.org = {
    install_info = {
      url = 'https://github.com/milisims/tree-sitter-org',
      revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
      files = {'src/parser.c', 'src/scanner.cc'},
    },
    filetype = 'org',
  }
  vim.cmd[[packadd nvim-treesitter]]
  vim.cmd[[TSUpdate]]

  require('orgmode').setup()
end

if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
  load_plugins()
  require('packer').sync()
  vim.cmd [[autocmd User PackerComplete ++once lua load_config()]]
else
  load_plugins()
  require('packer').sync()
  _G.load_config()
end
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'
