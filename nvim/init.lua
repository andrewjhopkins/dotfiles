local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.g.mapleader = " "

vim.cmd [[set fcs=eob:\ ]]
vim.cmd [[filetype plugin indent on]]

local options = {
  encoding = "utf-8",
  pumheight = 10, --Makes popup menu smaller
  fileencoding = "utf-8",
  ruler = true, --Show cursor position all the tim
  cmdheight=2, --More space for displaying messages
  mouse = "a", --Enable mouse
  splitbelow = true, --Horizontal splits will automatically be below
  splitright = true, --Vertical splits will automatically be right
  conceallevel = 0, --To see `` in markdown files
  tabstop = 2, --Insert 2 spaces for a tab
  shiftwidth = 2, --Change the number of space characters inserted for indentation
  smarttab = true, --Makes tabbing smarter will realize you have 2 vs 4
  expandtab = true, --Converts tabs to spaces
  smartindent = true, --Makes indenting smart
  autoindent = true,--Good auto indent
  laststatus = 2, --Always displays the status line
  number = true, --line numbers
  cursorline = true, --Enable highlighting of the current line
  background = "dark", --tell vim what the background color looks like
  showtabline = 2, --Always show tabs
  clipboard = "unnamedplus", --Copy paste between vim and everything else
  -- termguicolors = true
}

vim.opt.shortmess:append "c"
vim.wo.wrap = false
vim.opt.iskeyword:append("-") --Treat dash seperated words as a word text object

for option, value in pairs(options) do
    vim.opt[option] = value
end

-- Plugins --
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-lua/plenary.nvim'

  use 'nvim-tree/nvim-web-devicons'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    }
  }

  use 'folke/tokyonight.nvim'

  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'kyazdani42/nvim-web-devicons'}

end)

vim.opt.completeopt = {"menu", "menuone", "noselect"}

vim.cmd[[colorscheme tokyonight]]

-- Bufferline --
require('bufferline').setup{}
vim.keymap.set('n', '<leader>b]', ':bnext<CR>')
vim.keymap.set('n', '<leader>b[', ':bprev<CR>')

-- Nvim Tree --
require('nvim-tree').setup()
local nt_api = require("nvim-tree.api")

vim.keymap.set('n', '<leader>to', nt_api.tree.toggle, {})
vim.keymap.set('n', '<leader>tf', nt_api.tree.focus, {})

-- Telescope --
local tele = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', tele.find_files, {})
vim.keymap.set('n', '<leader>fg', tele.live_grep, {})

-- nvim-cmp --
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      --['<C-j>'] = cmp.mapping.scroll_docs(-4),
      --['<C-k>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })

-- Setup LSP --

require 'lspconfig'.gopls.setup{
  capabilities = capabilities,
  on_attach = function()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0 })
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = 0 })
    vim.keymap.set("n", "rn", vim.lsp.buf.rename, { buffer = 0 })
  end,
}

require 'lspconfig'.ocamllsp.setup{
  capabilities = capabilities,
  on_attach = function()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0 })
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = 0 })
    vim.keymap.set("n", "rn", vim.lsp.buf.rename, { buffer = 0 })
  end,
}

require 'lspconfig'.rust_analyzer.setup{
  capabilities = capabilities,
  on_attach = function()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0 })
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = 0 })
    vim.keymap.set("n", "rn", vim.lsp.buf.rename, { buffer = 0 })
  end,
}

require 'lspconfig'.clangd.setup{
  capabilities = capabilities,
  on_attach = function()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0 })
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = 0 })
    vim.keymap.set("n", "rn", vim.lsp.buf.rename, { buffer = 0 })
  end,
}
