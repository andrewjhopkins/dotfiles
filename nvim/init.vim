" set leader key
let g:mapleader = "\<Space>"

syntax enable " Enable syntax highlighting
set nowrap " Display long lines as just one line
set encoding=utf-8
set pumheight=10 " Makes popup menu smaller
set fileencoding=utf-8
set ruler " Show cursor position all the tim
set cmdheight=2 " More space for displaying messages
set iskeyword+=- " Treat dash separated words as a word text object
set mouse=a " Enable mouse
set splitbelow " Horizontal splits will automatically be below
set splitright " Vertical splits will automatically be right
set t_Co=256 " Support 256 colors
set conceallevel=0 " To see `` in markdown files
set tabstop=2 " Insert 2 spaces for a tab 
set shiftwidth=2 " Change the number of space characters inserted for indentation
set smarttab " Makes tabbing smarter will realize you have 2 vs 4
set expandtab " Converts tabs to spaces
set smartindent " Makes indenting smart
set autoindent " Good auto indent
set laststatus=0 " Always displays the status line
set number " line numbers
set cursorline " Enable highlighting of the current line
set background=dark " tell vim what the background color looks like
set showtabline=2 " Always show tabs
set formatoptions-=cro " Stop newline continution of comments
set clipboard=unnamedplus " Copy paste between vim and everything else

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/site/autoload/plugged')
	Plug 'scrooloose/NERDTree'
	Plug 'arcticicestudio/nord-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'

  Plug 'neovim/nvim-lspconfig'
  Plug 'kabouzeid/nvim-lspinstall'

  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'

  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'tpope/vim-fugitive'

  Plug 'tpope/vim-commentary'

  Plug 'numtostr/BufOnly.nvim', { 'on': 'BufOnly' }

  Plug 'simeji/winresizer'

  
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set completeopt=menu,menuone,noselect

lua << EOF
-- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body)

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        -- vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
    },
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      { name = 'vsnip' },

      -- For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

      { name = 'buffer' },
    }
  })

require'lspconfig'.tsserver.setup{
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

require'lspconfig'.pyright.setup{}
EOF

" airline
" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Switch to your current theme
let g:airline_theme = 'nord'

" lsp config
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
" autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)

" Mappings
" Need to fix this for mac
" Resize windows with space + hjkl 
" nnoremap <Leader-j> :resize -2<CR>
" nnoremap <Leader>k :resize +2<CR>
" nnoremap <Leader>h :vertical resize -2<CR>
" nnoremap <Leader>l :vertical resize +2<CR>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Telescope
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap :rg<CR> <cmd>lua require('telescope.builtin').live_grep()<cr>

" NerdTree
nnoremap :nt<CR> :NERDTree<CR>
nnoremap :ntf<CR> :NERDTreeFind<CR>
nnoremap :ntc<CR> :NERDTreeClose<CR>

" Lsp
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gH <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> gH <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> gh <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" vim commentary
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>

" change directory to current file
nnoremap :cdc<CR> :cd %:p:h<CR>:pwd<CR>

" delete all buffers except current
nnoremap :bda<CR> :%bd\|e#<CR>

colorscheme nord
