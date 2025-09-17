-- set leader key
vim.keymap.set('n', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true

-- vim.opt.termguicolors = true

-- never ever folding
vim.opt.foldenable = false
vim.opt.foldmethod = 'manual'
vim.opt.foldlevelstart = 99

-- Indentation
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300
vim.opt.timeoutlen = 300
-- keep more context on screen while scrolling
vim.opt.scrolloff = 2
-- never show me line breaks if they're not there
vim.opt.wrap = false
-- always draw sign column. prevents buffer moving when adding/deleting sign
vim.opt.signcolumn = 'yes'

vim.opt.swapfile = false
-- Permanent undo
vim.opt.undofile = true

-- keep current content top + left when splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

--" Decent wildmenu
-- in completion, when there is more than one match,
-- list all matches, and only complete to longest common match
vim.opt.wildmode = 'list:longest'
-- when opening a file with a command (like :e),
-- don't suggest files like there:
vim.opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site'
-- case-insensitive search/replace
vim.opt.ignorecase = true
-- unless uppercase in search term
vim.opt.smartcase = true
-- never ever make my terminal beep
vim.opt.vb = true
-- more useful diffs (nvim -d)
--- by ignoring whitespace
vim.opt.diffopt:append 'iwhite'
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append 'algorithm:histogram'
vim.opt.diffopt:append 'indent-heuristic'
-- show more hidden characters
-- also, show tabs nicer
vim.opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'
vim.opt.laststatus = 2
vim.opt.colorcolumn = '80'
vim.textwidth = '79'

-- hotkeys
vim.keymap.set('n', '<leader><leader>', '<C-^>')
vim.keymap.set('n', '<leader>n', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- quick-open
vim.keymap.set('n', '<C-p>', "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
-- search buffers
vim.keymap.set('n', '<leader>;', "<cmd>lua require('fzf-lua').buffers()<CR>")
-- search text
vim.keymap.set('n', '<leader>g', "<cmd>lua require('fzf-lua').live_grep({ cmd = 'rg --column --line-number --no-heading --color=always --smart-case' })<CR>")
-- quick-save
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')

-- <leader>p will paste clipboard into buffer
-- <leader>c will copy entire buffer into clipboard
vim.keymap.set('', '<leader>p', '<cmd>read !xsel --clipboard --output<cr>')
vim.keymap.set('n', '<leader>c', '<cmd>w !xsel -ib<cr><cr>')
vim.keymap.set('v', '<leader>c', '"+y')

vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'L', '$')

vim.keymap.set('n', '<C-q>', '<cmd>confirm qall<CR>')

-- "very magic" (less escaping needed) regexes by default
-- vim.keymap.set('n', '?', '?\\v')
-- vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('c', '%s/', '%sm/')

-- open new file adjacent to current file
vim.keymap.set('n', '<leader>e', ':e <C-R>=expand("%:p:h") . "/" <cr>')
-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- qflist
vim.keymap.set('n', '<M-q>', function()
  local qf_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_open = true
      break
    end
  end
  if qf_open then
    vim.cmd 'cclose'
  else
    vim.cmd 'copen'
  end
end, { silent = true })
vim.keymap.set('n', '<M-n>', '<cmd>cnext<CR>')

-- Navigate to Previous Entry
vim.keymap.set('n', '<M-p>', '<cmd>cprev<CR>')

-- plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local on_attach = function(client, bufnr)
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Buffer local mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  -- vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi', require('fzf-lua').lsp_implementations, opts)
  vim.keymap.set('n', 'gr', require('fzf-lua').lsp_references, opts)
  vim.keymap.set('n', 'gy', require('fzf-lua').lsp_typedefs, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, opts)
  -- vim.keymap.set({ 'n', 'x' }, '<leader>a', require('fzf-lua').lsp_code_actions, opts)

  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr) then
    vim.lsp.inlay_hint.enable()
    vim.keymap.set('n', '<leader>ti', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
      print('InlayHint: ' .. vim.inspect(vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }))
    end, opts)
  end

  if client.name == 'typescript-tools' then
    client.server_capabilities.documentFormattingProvider = false
  end
end

require('lazy').setup {
  -- main color scheme
  {
    'wincent/base16-nvim',
    lazy = false, -- load at start
    priority = 1000, -- load first
    config = function()
      if vim.env.BASE16_THEME then
        if not vim.g.colors_name or vim.g.colors_name ~= 'base16-' .. vim.env.BASE16_THEME then
          vim.g.base16colorspace = 256
          -- vim.cmd('colorscheme base16-' .. vim.env.BASE16_THEME)
          vim.cmd('colorscheme ' .. vim.env.BASE16_THEME) -- strip prefix https://github.com/wincent/base16-nvim/commit/178bebdd6342c59151f6cfa2553d8e0f3f8b6a69
        end
      end
    end,
  },
  -- quick navigation
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  -- better %
  {
    'andymass/vim-matchup',
    init = function()
      -- modify your configuration vars here
      vim.g.matchup_treesitter_stopline = 500
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }

      -- or call the setup function provided as a helper. It defines the
      -- configuration vars for you
      require('match-up').setup {
        treesitter = {
          stopline = 500,
        },
      }
    end,
  },
  -- auto-cd to root of git project
  {
    'notjedi/nvim-rooter.lua',
    config = function()
      require('nvim-rooter').setup()
    end,
  },
  -- fzf support for ^p
  {
    'ibhagwan/fzf-lua',
    dependencies = {
      { 'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
    },
    config = function()
      require('fzf-lua').setup {
        'fzf-native',
        keymap = {
          builtin = {
            ['<c-f>'] = 'preview-page-down',
            ['<c-b>'] = 'preview-page-up',
          },
          fzf = {
            ['ctrl-q'] = 'select-all+accept',
            ['ctrl-u'] = 'half-page-up',
            ['ctrl-d'] = 'half-page-down',
            ['ctrl-x'] = 'jump',
            ['ctrl-f'] = 'preview-page-down',
            ['ctrl-b'] = 'preview-page-up',
          },
        },
        winopts = {
          width = 0.8,
          height = 0.8,
          row = 0.5,
          col = 0.5,
          preview = {
            default = 'bat',
          },
        },
        fzf_opts = {
          ['--layout'] = 'default',
        },
      }
      vim.keymap.set('n', '<leader>d', require('fzf-lua').diagnostics_workspace)
    end,
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
      -- Schema information
      'b0o/SchemaStore.nvim',
    },
    config = function()
      -- Setup language servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'none', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        ruff = {
          trace = 'messages',
          init_options = {
            settings = {
              logLevel = 'debug',
            },
          },
        },

        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              cargo = {
                features = 'all',
              },
              checkOnSave = {
                enable = true,
              },
              check = {
                command = 'clippy',
              },
              imports = {
                group = {
                  enable = false,
                },
              },
              completion = {
                postfix = {
                  enable = false,
                },
              },
            },
          },
        },
        taplo = {},

        -- ts_ls = {
        --   settings = {
        --     typescript = {
        --       inlayHints = {
        --         includeInlayEnumMemberValueHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayParameterNameHints = 'literal',
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayVariableTypeHints = false,
        --         includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        --       },
        --     },
        --     javascript = {
        --       inlayHints = {
        --         includeInlayEnumMemberValueHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayParameterNameHints = 'literal',
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayVariableTypeHints = false,
        --         includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        --       },
        --     },
        --     completion = {
        --       completeFunctionCalls = true,
        --     },
        --   },
        -- },
        biome = {},
        tailwindcss = {
          -- root_dir = function(fname)
          --   local root_pattern = require('lspconfig').util.root_pattern('tailwind.config.cjs', 'tailwind.config.js', 'postcss.config.js')
          --   return root_pattern(fname)
          -- end,
        },
        html = {},
        cssls = {},
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },

        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = '',
              },
              schemas = require('schemastore').yaml.schemas(),
            },
          },
        },

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        bashls = {},
        intelephense = {},
      }

      require('mason').setup()

      -- add other tools here
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'prettierd',
        'eslint_d',
        'shellcheck',
        'shfmt',
        'phpcs',
        'php-cs-fixer',
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      ---@diagnostic disable-next-line: missing-fields
      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            server.on_attach = on_attach
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require('typescript-tools').setup {
        on_attach = on_attach,
        settings = {
          tsserver_file_preferences = {
            includeInlayParameterNameHints = 'all',
            includeCompletionsForModuleExports = true,
            quotePreference = 'auto',
          },
          tsserver_format_options = {
            allowIncompleteCompletions = false,
            allowRenameOfImportPath = false,
          },
        },
      }
    end,
  },
  -- Linter
  {
    'mfussenegger/nvim-lint',
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {
        python = { 'ruff' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        sh = { 'shellcheck' },
        rust = { 'clippy' },
        php = { 'phpcs' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          pcall(require, 'lint.try_lint')
        end,
      })

      vim.keymap.set('n', '<leader>ll', function()
        lint.try_lint()
      end, { desc = 'Trigger linting for current file' })
    end,
  },
  -- Autoformat
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format {
            async = false,
            lsp_format = 'fallback',
            timeout_ms = 1000,
          }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      -- format_on_save = function(bufnr)
      --   -- Disable "format_on_save lsp_fallback" for languages that don't
      --   -- have a well standardized coding style. You can add additional
      --   -- languages here or re-enable it for the disabled ones.
      --   local disable_filetypes = { c = true, cpp = true }
      --   local lsp_format_opt
      --   if disable_filetypes[vim.bo[bufnr].filetype] then
      --     lsp_format_opt = 'never'
      --   else
      --     lsp_format_opt = 'fallback'
      --   end
      --   return {
      --     timeout_ms = 500,
      --     lsp_format = lsp_format_opt,
      --   }
      -- end,
      formatters_by_ft = {
        lua = { 'stylua' },
        rust = { 'rustfmt', lsp_format = 'fallback' },
        python = function(bufnr)
          if require('conform').get_formatter_info('ruff_format', bufnr).available then
            return { 'ruff_format' }
          else
            return { 'isort', 'black' }
          end
        end,
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        sh = { 'shfmt' },
        php = { 'php_cs_fixer' },
      },
    },
  },
  -- LSP-based code-completion
  {
    'hrsh7th/nvim-cmp',
    -- load cmp on InsertEnter
    event = 'InsertEnter',
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require 'cmp'
      cmp.setup {
        preselect = cmp.PreselectMode.None,
        ---@diagnostic disable-next-line: missing-fields
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
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-y>'] = cmp.mapping(
            cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            },
            { 'i', 'c' }
          ),
          -- Accept currently selected item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ['<CR>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Insert },
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'path' },
          { name = 'buffer', keyword_length = 4 },
        }),
        -- experimental = {
        --   ghost_text = true,
        -- },
      }
      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
        ---@diagnostic disable-next-line: missing-fields
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = 'lazydev',
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  {
    'ray-x/lsp_signature.nvim',
    event = 'InsertEnter',
    opts = {
      bind = true,
      floating_window = false,
      doc_lines = 0,
      handler_opts = {
        border = 'none',
      },
      hint_prefix = {
        above = '↙ ', -- when the hint is on the line above the current line
        current = '← ', -- when the hint is on the same line
        below = '↖ ', -- when the hint is on the line below the current line
      },
    },
    config = function(_, opts)
      -- Get signatures (and _only_ signatures) when in argument lists.
      require('lsp_signature').setup(opts)
    end,
  },
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'javascript',
        'lua',
        'markdown',
        'python',
        'ron',
        'rust',
        'tsx',
        'typescript',
        'php',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = false, disable = { 'ruby' } },
      -- matchup = {
      --   enable = true, -- mandatory, false will disable the whole extension
      --   disable = { 'c', 'ruby' }, -- optional, list of language that will be disabled
      -- },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  -- {
  --   'chakrit/vim-thai-keys',
  --   lazy = false,
  -- },
  {
    'ivanesmantovich/xkbswitch.nvim',
    event = 'VeryLazy',
    keys = {
      { '<Esc>', mode = 'i' },
      { '<C-[>', mode = 'i' },
      { '<C-บ>', mode = 'i', '<Esc>' },
      { '<C-c>', mode = 'i', '<Esc>' },
      { '<C-แ>', mode = 'i', '<Esc>' },
    },
    config = function(_, opts)
      require('xkbswitch').setup()
    end,
  },
  -- Comment
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function(_, opts)
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
      local get_option = vim.filetype.get_option
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.filetype.get_option = function(filetype, option)
        return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring() or get_option(filetype, option)
      end
    end,
  },
}

-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  command = 'silent! lua vim.hl.on_yank({ timeout = 500 })',
})

-- jump to last edit position on opening file
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function(ev)
    if vim.fn.line '\'"' > 1 and vim.fn.line '\'"' <= vim.fn.line '$' then
      -- except for in git commit messages
      -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
      if not vim.fn.expand('%:p'):find('.git', 1, true) then
        vim.cmd 'exe "normal! g\'\\""'
      end
    end
  end,
})
