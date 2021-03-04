let mapleader=" "
filetype plugin on
set encoding=UTF-8
syntax on
set autoread
set updatetime=300
set showmode
set wildmenu
set wildignorecase

set autoindent
set cindent
set smartindent
set noswapfile
set nobackup
set ignorecase
set number relativenumber
set ruler
set numberwidth=4
set hidden
set cursorline
set scrolloff=10

set splitright
set splitbelow

inoremap jk <ESC>

highlight! ExtraWhitespace guibg='#50FA7B'

" Movement for split windows
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Resize windows quickly
map <silent><a-h> :vertical resize -1<cr>
map <silent><a-j> :resize +1<cr>
map <silent><a-k> :resize -1<cr>
map <silent><a-l> :vertical resize +1<cr>

" Tab Options
set shiftwidth=4
set tabstop=4
set softtabstop=0
set expandtab

"This unsets the "last search pattern" register by hitting return
nnoremap <silent><ESC><ESC> :noh<CR>

" Disable automatic comment continuation
autocmd! FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Source Vim configuration file and install plugins
nnoremap <silent><leader>rrc :source ~/.config/nvim/init.vim \| :PlugInstall<CR>
nnoremap <leader>rc :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>b :buffers<CR>:b 
nnoremap <c-6> :call feedkeys("\<c-^")<CR>

call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tomasiser/vim-code-dark'
Plug 'jiangmiao/auto-pairs'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" JAVASCRIPT
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'

" neovim-lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

colorscheme gruvbox
set background=dark

" =========== File Tree ========
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
let g:nvim_tree_follow = 1
let g:nvim_tree_bindings = {
    \ 'edit':            ['<CR>', 'o', 'l'],
    \ 'close_node':      ['<S-CR>', '<BS>', 'h'],
    \ }

" =========== FZF =============
" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:40%'
nmap <leader>p :GFiles<CR>

" =========== Telescope config ==========
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" ============== LSP ===========
" ///////////// Key Bindings //////////
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gt   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>

" ///////////// Auto Completion //////
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
let g:completion_matching_ignore_case = 1

" ///////////// Typescript ///////////
lua <<EOF
    require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}

    require'nvim-treesitter.configs'.setup {
      highlight = {
          enable = true,              -- false will disable the whole extension
      },
    }
EOF
