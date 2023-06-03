-- Package Management
local use = require('packer').use
require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
	use 'wbthomason/packer.nvim'
	-- The tpope Train
	use 'tpope/vim-vinegar' -- better netrw
	use 'tpope/vim-surround' -- mappings to edit surroundings: cs"/ds'
	use 'tpope/vim-commentary' -- commenting: gcc/gcgc
	use 'tpope/vim-unimpaired' -- complementary mappings: ]x/[y
	use 'tpope/vim-dispatch' -- compiler plugin
	use 'tpope/vim-characterize'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-scriptease'

	use 'junegunn/vim-easy-align'
	use 'airblade/vim-gitgutter'
	use 'mhinz/vim-startify'
	use { 
		"sindrets/diffview.nvim",
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			vim.cmd[[set fillchars+=diff:╱]]
		end
	}
	use 'karb94/neoscroll.nvim'
	use 'rmehri01/onenord.nvim'
	use 'marko-cerovac/material.nvim'
	use 'talha-akram/noctis.nvim'
	use 'rcarriga/nvim-notify'
	use 'christoomey/vim-tmux-navigator'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'sheerun/vim-polyglot'
	use {'neoclide/coc.nvim', branch = 'release'}
	use {
		'xeluxee/competitest.nvim',
		requires = 'MunifTanjim/nui.nvim',
		config = function() require'competitest'.setup() end
	}
	use {'jalvesaq/Nvim-R', branch = 'stable'}
	use {
  	"folke/trouble.nvim",
  	requires = "kyazdani42/nvim-web-devicons",
  	config = function()
    	require("trouble").setup {
				mode = "loclist", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
			}
  	end
	}
	use { 'akinsho/bufferline.nvim', 
				requires = 'kyazdani42/nvim-web-devicons',
				-- commit = "0a83c615a8ab49718d9b4cdc60127003307829b2",
	}
	use 'mfussenegger/nvim-dap'
	use { 'ibhagwan/fzf-lua',
 	 	-- optional for icon support
  	requires = { 'kyazdani42/nvim-web-devicons' }
	}
	use { 'junegunn/fzf', run = './install --bin', }
	
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'lervag/vimtex'

  -- Personal additions
	use { 'VonHeikemen/fine-cmdline.nvim', requires = {{'MunifTanjim/nui.nvim'}} }
	use 'lambdalisue/suda.vim'
	use {
		'TimUntersberger/neogit',
		config = function()
			require("neogit").setup {
				use_magit_keybindings = true,
				mappings = {
					status = {
						["p"] = "",
						["p"] = "PushPopup",
						["P"] = "",
						["P"] = "PullPopup",
					}
				}
			}
		end
	}
	use {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require "icons"
        end,
  	  }
	use 'vim-pandoc/vim-pandoc'
	use 'vim-pandoc/vim-pandoc-syntax'
	-- use 'SirVer/ultisnips' -- ruins <tab>
	-- use 'kyazdani42/nvim-tree.lua'
	use 'junegunn/goyo.vim'
	use 'maguroguma/vim-oj-helper'
	use 'nvim-treesitter/nvim-treesitter' -- :TSUpdate; ;TSInstall
	use 'NvChad/nvim-colorizer.lua' -- Rainbow mod
	use {'nvim-orgmode/orgmode', config = function()
        require('orgmode').setup{}
	end
	}
	use 'nvim-telescope/telescope.nvim'
	-- use 'liuchengxu/vim-which-key'
end)
