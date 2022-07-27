local colorscheme = require "colorscheme"
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
  termguicolors = true
}

vim.opt.shortmess:append "c"
vim.wo.wrap = false
vim.opt.iskeyword:append("-") --Treat dash seperated words as a word text object

for option, value in pairs(options) do
    vim.opt[option] = value
end

colorscheme.init()
