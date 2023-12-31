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

" Commenting
Plug 'numToStr/Comment.nvim'

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

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }

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

require('Comment').setup()

EOF
