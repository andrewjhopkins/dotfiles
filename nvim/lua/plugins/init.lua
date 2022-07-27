local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
end
vim.cmd [[packadd packer.nvim]]

local _packer, packer = pcall(require, "packer")

if not _packer then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "single" }
        end,
        prompt_border = "single",
    },
    git = {
        clone_timeout = 600,
    },
    auto_clean = true,
    compile_on_sync = true,
}

return packer.startup(function(use)
  use { "lewis6991/impatient.nvim" }
  use { "wbthomason/packer.nvim" }

  -- UI
  use { "folke/tokyonight.nvim" }
  use { "projekt0n/github-nvim-theme" }
  use { "rmehri01/onenord.nvim" }
  use {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require "plugins.configs.icons"
    end,
  }

  use {
    "akinsho/bufferline.nvim",
    tag = "v2.0.0",
    after = "nvim-web-devicons",
    config = function()
        require "plugins.configs.bufferline"
    end,
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
      }
    end
  }

  use {
    "karb94/neoscroll.nvim",
    config = function()
      require "plugins.configs.neoscroll"
    end,
  }

  use {
    "feline-nvim/feline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require "plugins.configs.feline"
    end,
  }

  -- Utilities
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    "kyazdani42/nvim-tree.lua",
    after = "nvim-web-devicons",
    config = function()
     require "plugins.configs.nvimtree"
    end,
  }

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-node-modules.nvim",
    },
    config = function()
      require "plugins.configs.telescope"
    end,
  }

  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  use { "nvim-lua/popup.nvim" }
  use { "nvim-lua/plenary.nvim" }

  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require "plugins.configs.indent"
    end,
  }
  use {
    "windwp/nvim-autopairs",
    config = function()
        require "plugins.configs.autopairs"
    end,
  }

  use { "norcalli/nvim-colorizer.lua" }

  -- Comment
  use {
    "numToStr/Comment.nvim",
    config = function()
        require "plugins.configs.comment"
    end,
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    requires = {
      "folke/lua-dev.nvim",
      "jose-elias-alvarez/typescript.nvim",
      "williamboman/nvim-lsp-installer",
    },
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  use {
    "j-hui/fidget.nvim",
    config = function()
        require "plugins.configs.fidget"
    end,
  }

  -- Completion
  use {
    "hrsh7th/nvim-cmp",
    requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
        require "plugins.configs.cmp"
    end,
  }

  -- Snippets
  use {
    "dsznajder/vscode-es7-javascript-react-snippets",
    run = "yarn install --frozen-lockfile && yarn compile",
  }

  use { "rafamadriz/friendly-snippets" }

end)
