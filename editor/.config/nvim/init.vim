" Install vim-plug if not found
if empty(glob('~/.local/share/nvim/site/autoload'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
" Improve editor
Plug 'airblade/vim-rooter'
Plug 'andymass/vim-matchup'
Plug 'editorconfig/editorconfig-vim'
Plug 'justinmk/vim-sneak'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lyokha/vim-xkbswitch'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
" Autocompletion
Plug 'L3MON4D3/LuaSnip'
Plug 'folke/lua-dev.nvim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'neovim/nvim-lspconfig'
Plug 'rafamadriz/friendly-snippets'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'simrat39/rust-tools.nvim'
" Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'
" nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects', { 'branch': '0.5-compat' }
" Color scheme
Plug 'chriskempson/base16-vim'
call plug#end()

if has('nvim')
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
  set inccommand=nosplit
  noremap <C-q> :confirm qall<CR>
end

" disable builtin
let g:loaded_matchit = 1

" deal with colors
hi Normal ctermbg=NONE
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif
" Comments highlighting
function! s:base16_customize() abort
  call Base16hi('Comment', g:base16_gui09, '', g:base16_cterm09, '', '', '')
  call Base16hi('RustInlayHint', g:base16_gui0C, '', g:base16_cterm0C, '', '', '')
endfunction
augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * silent! call s:base16_customize()
augroup END
" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require('vim.highlight').on_yank()
augroup END

" Editor settings
set nocompatible
filetype plugin indent on
syntax on
set encoding=utf-8
set nobackup
set nowritebackup
set noswapfile
set nojoinspaces
set noshowmode
set nowrap
set printencoding=utf-8
set printfont=:h10
set printoptions=paper:letter
set scrolloff=2
set signcolumn=yes

" Timings
set hidden
set timeoutlen=250 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set updatetime=250 " You will have bad experience for diagnostic messages when it's default 4000.

" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=iwhite " No whitespace in vimdiff
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" Folds
set foldexpr=nvim_treesitter#foldexpr()
set foldmethod=expr
set foldlevel=20
set foldlevelstart=20

" Window spliting and buffers
set splitright
set splitbelow

" Permanent undo
set undodir=~/.cache/vim/undo
set undofile

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Indentations
set autoindent
set expandtab
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2
set tabstop=2

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" GUI settings
set guioptions-=T " Remove toolbar
set backspace=2 " Backspace over newlines
set cmdheight=2
set colorcolumn=80 " and give me a colored column
set laststatus=2
set mouse=a " Enable mouse usage (all modes) in terminals
set number " Also show current absolute line
set relativenumber " Relative line numbers
set shortmess+=c " don't give |ins-completion-menu| messages.
set showcmd " Show (partial) command in status line.
set textwidth=79
set ttyfast
set vb t_vb= " No more beeps

" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=500

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" Key remapping
let mapleader = "\<Space>"
inoremap <C-c> <Esc>
nmap <leader>w :w<CR>
noremap <leader>n :nohlsearch<CR>

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <C-^>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Neat X clipboard integration
noremap <leader>p :read !xsel --clipboard --output<CR>
noremap <leader>c :w !xsel -ib<CR><CR>

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" Find files
nnoremap <C-p> <cmd>lua project_files()<CR>
nnoremap <leader>g <cmd>Telescope live_grep<CR>
nnoremap <leader>; <cmd>Telescope buffers<CR>
nnoremap <leader>h <cmd>Telescope help_tags<CR>

lua <<EOF
-- lspconfig
local debounce_text_changes = 500
local lspconfig = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
  buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua require("telescope.builtin").lsp_code_actions()<CR>', opts)
  buf_set_keymap('v', '<leader>a', '<cmd>lua require("telescope.builtin").lsp_range_code_actions()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua require("telescope.builtin").lsp_document_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>o', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>s', '<cmd>lua require("telescope.builtin").lsp_workspace_symbols()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  if client.name == 'rust_analyzer' then
    buf_set_keymap('n', '<F5>', '<cmd>RustRun<CR>', opts)
    buf_set_keymap('n', '<leader>t', '<cmd>RustRunnables<CR>', opts)
    buf_set_keymap('n', 'J', '<cmd>RustJoinLines<CR>', opts)
  end
end
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local lsp_servers = {
  'cssls',
  'html',
  'jsonls',
  'pyright',
  'sumneko_lua',
  'tailwindcss',
  'tsserver',
  'vuels',
}

-- config that activates keymaps and enables snippet support
local function make_config()
  -- Enable (broadcasting) snippet capability for completion
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  return {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      allow_incremental_sync = true,
      debounce_text_changes = debounce_text_changes,
    },
  }
end

for _, lsp in ipairs(lsp_servers) do
  local config = make_config()

  if lsp == 'sumneko_lua' then
    -- lua development
    local sumneko_root_path = vim.fn.stdpath('data') .. '/lua-language-server'
    local sumneko_binary = sumneko_root_path .. '/bin/Linux/lua-language-server'
    local luadev = require('lua-dev').setup {
      lspconfig = {
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
      },
    }
    config = vim.tbl_deep_extend('force', {}, config, luadev)
    
  end

  lspconfig[lsp].setup(config)
end

-- rust-tools
local opts = {
  tools = { -- rust-tools options
    -- automatically set inlay hints (type hints)
    -- There is an issue due to which the hints are not applied on the first
    -- opened file. For now, write to the file to trigger a reapplication of
    -- the hints or just run :RustSetInlayHints.
    -- default: true
    autoSetHints = true,
    -- whether to show hover actions inside the hover window
    -- this overrides the default hover handler so something like lspsaga.nvim's hover would be overriden by this
    -- default: true
    hover_with_actions = true,
    -- These apply to the default RustRunnables command
    runnables = {
      -- whether to use telescope for selection menu or not
      -- default: true
      use_telescope = true,
      -- rest of the opts are forwarded to telescope
    },
    -- These apply to the default RustSetInlayHints command
    inlay_hints = {
      -- wheter to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,
      -- prefix for parameter hints
      -- default: '<-'
      parameter_hints_prefix = ':',
      -- prefix for all the other hints (type, chaining)
      -- default: '=>'
      other_hints_prefix = '▶ ',
      -- whether to align to the lenght of the longest line in the file
      max_len_align = false,
      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,
      -- whether to align to the extreme right or not
      right_align = false,
      -- padding from the right if right_align is true
      right_align_padding = 7,
      -- The color of the hints
      highlight = 'RustInlayHint',
    },
    hover_actions = {
      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = 'none',
      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = false,
    },
  },
-- all the opts to send to nvim-lspconfig
-- these override the defaults set by rust-tools.nvim
-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      allow_incremental_sync = true,
      debounce_text_changes = debounce_text_changes,
    },
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importGranularity = "module",
          importEnforceGranularity = true,
        },
        cargo = {
          loadOutDirsFromCheck = true,
          allFeatures = true,
        },
        procMacro = {
          enable = true,
        },
        checkOnSave = {
          command = "clippy",
        },
        experimental = {
          procAttrMacros = true,
        },
        hoverActions = {
          references = true,
        },
        lens = {
          methodReferences = true,
          references = true,
        },
      },
    },
  }, -- rust-analyer options
}
require('rust-tools').setup(opts)

-- LuaSnip settings
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local check_back_space = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end
local luasnip = require("luasnip")

-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup {
  completion = {
    completeopt = 'menuone,noselect',
  },
  formatting = {
    format = function(entry, vim_item)
      -- set a name for each source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      })[entry.source.name]
      return vim_item
    end,
  },
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t('<C-n>'), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(t('<Plug>luasnip-expand-or-jump'), '')
      elseif check_back_space() then
        vim.fn.feedkeys(t('<Tab>'), 'n')
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t('<C-p>'), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'path' },
  },
}

-- you need setup cmp first put this after cmp.setup()
require('nvim-autopairs').setup()
require("nvim-autopairs.completion.cmp").setup {
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true -- automatically select the first item
}

-- treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'css',
    'go',
    'html',
    'json',
    'lua',
    'python',
    'rust',
    'tsx',
    'typescript',
    'vue',
  },
  autotag = { enable = true },
  highlight = { enable = true },
  indent = {
    enable = true,
    disable = { 'python' }
  },
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
    disable = { "c", "ruby" },  -- optional, list of language that will be disabled
  },
  textobjects = {
    lsp_interop = {
      border = 'none',
      enable = true,
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
    },
    move = {
      enable = true,
      goto_next_start = {
          [']m'] = '@function.outer',
      },
      goto_previous_start = {
          ['[m'] = '@function.outer',
      },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@functionn.outer',
        ['if'] = '@function.inner',
      },
    },
    swap = { enable = false },
  },
}

-- telescope
local telescope = require('telescope')
telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = require('telescope.actions').close,
        ['<C-u>'] = false, -- inoremap'd to clear line
        ['<C-a>'] = false, -- inoremap'd to move to start of line
        ['<C-e>'] = false, -- inoremap'd to move to end of line
        ['<C-w>'] = false, -- inoremap'd to delete previous word
        ['<C-b>'] = require('telescope.actions').preview_scrolling_up,
        ['<C-f>'] = require('telescope.actions').preview_scrolling_down,
        ['<C-q>'] = require('telescope.actions').send_to_qflist,
        ['<C-l>'] = require('telescope.actions').smart_send_to_loclist,
      }
    },
  },
}
telescope.load_extension('fzf')
_G.project_files = function()
  local opts = {} -- define here if you want to define something
  local builtin = require('telescope.builtin')
  local ok = pcall(builtin.git_files, opts)
  if not ok then builtin.find_files(opts) end
end

-- gitsings
require('gitsigns').setup()
EOF
" end lua config

