" https://github.com/junegunn/vim-plug Plugin Manager.
" Run :PlugInstall to install plugins
call plug#begin()
" File Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Color Scheme
Plug 'Mofiqul/vscode.nvim'
" Ruby
Plug 'vim-ruby/vim-ruby'
" Codium (AI)
"Plug 'Exafunction/codeium.vim'
" Copilot
Plug 'github/copilot.vim'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'HiPhish/nvim-ts-rainbow2', {'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'luochen1990/rainbow'

" Status Line
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'

" Javascript Suggestions
Plug 'leafOfTree/vim-vue-plugin'

" Indentation
Plug 'NMAC427/guess-indent.nvim'

" LSP
Plug 'williamboman/mason.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp' " TODO: Setup

" File Explorer
Plug 'nvim-tree/nvim-tree.lua'

call plug#end()


let g:rainbow_active = 1
let g:vim_vue_plugin_config = {
      \'syntax': {
      \   'template': ['html'],
      \   'script': ['javascript'],
      \   'style': ['css'],
      \},
      \'full_syntax': [],
      \'initial_indent': [],
      \'attribute': 0,
      \'keyword': 0,
      \'foldexpr': 0,
      \'debug': 0,
      \}
" Map the leader key to ,
let mapleader="\<SPACE>"

" Formatting Options {

  set showmatch
  set number
  "set expandtab
  set tabstop=2
  set smartindent
  " Whitespace
  " autotrim
  autocmd BufWritePre * :%s/\s\+$//e
  " highlight
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
" }
"
" Plugin Configs
" Fzf
  nnoremap <C-p> :GFiles<CR>
  nnoremap <C-b> :Buffers<CR>
  nnoremap <C-f> :Ag<CR>
  nnoremap <C-y> :let @+ = expand("%")<CR>

" File Explorer Toggle
nnoremap <C-S-t> :NvimTreeToggle<CR>

" Lua Config
lua << EOF
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- VSCode Plugin Theme
vim.o.background = 'dark'
require('vscode').load()

vim.opt.termguicolors = true
require("nvim-tree").setup()

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
require("indent_blankline").setup {
				space_char_blankline = " ",
				char_highlight_list = {
								"IndentBlanklineIndent1",
								"IndentBlanklineIndent2",
								"IndentBlanklineIndent3",
								"IndentBlanklineIndent4",
								"IndentBlanklineIndent5",
								"IndentBlanklineIndent6",
				},
}

require'nvim-treesitter.configs'.setup {
				ensure_installed = { "ruby", "vue", "markdown" },
				highlight = {
								enable = true,
								-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
								-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
								-- Using this option may slow down your editor, and you may see some duplicate highlights.
								-- Instead of true it can also be a list of languages
								additional_vim_regex_highlighting = false,
				},
}

require("lualine").setup()
require('guess-indent').setup {}
require("mason").setup()

-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.solargraph.setup {}
lspconfig.eslint.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
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

EOF
