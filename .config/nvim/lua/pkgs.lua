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
	use 'tpope/vim-eunuch' -- For sudo, check x11-ssh-keypass
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
	use 'christoomey/vim-tmux-navigator'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'sheerun/vim-polyglot'
	use {
				"windwp/nvim-autopairs",
    		config = function() 
					require("nvim-autopairs").setup {}
				end
			}

	use {'neoclide/coc.nvim', branch = 'release'}
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
	use 'TimUntersberger/neogit'
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
	use 'nvim-treesitter/nvim-treesitter' -- :TSUpdate; ;TSInstall
	use 'NvChad/nvim-colorizer.lua' -- Rainbow mod
	use {'nvim-orgmode/orgmode', config = function()
        require('orgmode').setup{}
	end
	}
	-- use 'liuchengxu/vim-which-key'
end)




