require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- use 'shaunsingh/nord.nvim'
  use 'Mofiqul/dracula.nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"}
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  use {'windwp/nvim-ts-autotag'} -- Automatically closes tags
  use {'p00f/nvim-ts-rainbow'} -- Highlights different pairs of brackets in different colors
  use {'windwp/nvim-autopairs'} -- Automatically closes parentheses, brackets and quotes
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use { 'mhinz/vim-startify' }
end)
