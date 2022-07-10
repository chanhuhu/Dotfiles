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
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'neovim/nvim-lspconfig'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'simrat39/rust-tools.nvim'
Plug 'williamboman/nvim-lsp-installer'
" Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'
" nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" Color scheme
Plug 'chriskempson/base16-vim'
call plug#end()

if has('nvim')
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
  set inccommand=nosplit
  noremap <C-q> :confirm qall<CR>
end

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
call Base16hi('Comment', g:base16_gui09, '', g:base16_cterm09, '', '', '')
call Base16hi('RustInlayHint', g:base16_gui0C, '', g:base16_cterm0C, '', '', '')
" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require('vim.highlight').on_yank()
augroup END

" auto-format
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 100)

" Editor settings
set nocompatible
filetype plugin indent on
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
syntax on
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
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>s', '<cmd>lua require("telescope.builtin").lsp_workspace_symbols()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  if client.name == 'rust_analyzer' then
    buf_set_keymap('n', 'rr', '<cmd>RustRun<CR>', opts)
    buf_set_keymap('n', 'rt', '<cmd>RustRunnables<CR>', opts)
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
  'rust_analyzer',
  'tailwindcss',
  'tsserver',
}

require("nvim-lsp-installer").setup({ automatic_installation = true })
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
      debounce_text_changes = 500,
    },
  }
end
local lsp_config = make_config()
for _, lsp in ipairs(lsp_servers) do
  if lsp == 'rust_analyzer' then
    local opts = {
      tools = {
        inlay_hints = {
          parameter_hints_prefix = ':',
          other_hints_prefix = '▶ ',
          highlight = 'RustInlayHint',
        },
        hover_actions = {
          border = 'none',
        },
      },
      server = vim.tbl_deep_extend('force', {
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
      }, lsp_config),
    }
    require('rust-tools').setup(opts)
  else
    lspconfig[lsp].setup(lsp_config)
  end
end

local luasnip = require('luasnip')
-- Keymaps for Luasnip
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end, { silent = true })

vim.keymap.set("i", "<C-l>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end)

-- nvim-cmp setup
local cmp = require('cmp')
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
cmp.setup {
  formatting = {
    format = function(entry, vim_item)
      -- set a name for each source
      vim_item.menu = ({
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        path = '[Path]',
      })[entry.source.name]
      return vim_item
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'path' },
  }, {
    { name = 'buffer', keyword_length = 4 },
  }),
}

-- you need setup cmp first put this after cmp.setup()
require('nvim-autopairs').setup()
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
require('nvim-autopairs').remove_rule("'")
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

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
        ['<Esc>'] = require('telescope.actions').close,
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

