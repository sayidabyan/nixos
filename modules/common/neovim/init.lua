local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
    format = require('lspkind').cmp_format({
      menu = {
        nvim_lsp = '[LSP]',
        nvim_lsp_signature_help = '[Signature]',
        nvim_lsp_document_symbol = '[Document]',
        treesitter = '[Tree]',
        npm = '[NPM]',
        luasnip = '[LuaSnip]',
      },
    }),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item()),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item()),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp_document_symbol' },
    { name = 'treesitter' },
    { name = 'npm' },
    { name = 'luasnip' },
  },
})

require('luasnip.loaders.from_vscode').lazy_load()

require('telescope').load_extension('fzf')

local telescopeActions = require('telescope.actions')
local fb_actions = require'telescope'.extensions.file_browser.actions

require('telescope').setup({
  defaults = {
    layout_strategy = 'flex',
    mappings = {
      i = {
        ['<C-j>'] = telescopeActions.cycle_history_next,
        ['<C-k>'] = telescopeActions.cycle_history_prev,
      },
    },
  },
  extensions = {
    file_browser = {
      initial_mode = 'normal',
      mappings = {
        ['n'] = {
          ['l'] = telescopeActions.select_default,
          ['h'] = fb_actions.goto_parent_dir,
        },
      },
    },
  },
})
local telescopeBuiltin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', function()
  telescopeBuiltin.git_files({ show_untracked = true })
end, { desc = '[F]ind Git [F]iles' })
vim.keymap.set('n', '<leader>fF', function()
  telescopeBuiltin.find_files({
    hidden = true,
    no_ignore = true,
    no_ignore_parent = true,
  })
end, { desc = '[F]ind All [F]iles' })
vim.keymap.set('n', '<leader>fw', telescopeBuiltin.grep_string,
  { desc = '[F]ind [W]ord' })
vim.keymap.set('n', '<leader>fg', telescopeBuiltin.live_grep,
  { desc = '[F]ind Live [G]rep' })
vim.keymap.set('n', '<leader>fb', telescopeBuiltin.buffers,
  { desc = '[F]ind [B]uffer' })
vim.keymap.set('n', '<leader>fr', function()
  telescopeBuiltin.oldfiles({ only_cwd = true })
end, { desc = '[F]ind [W]ord' })
vim.keymap.set('n', '<leader>fq', telescopeBuiltin.quickfix,
  { desc = '[F]ind [Q]uickfix' })
vim.keymap.set('n', '<leader>fh', telescopeBuiltin.help_tags,
  { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 0,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

require('nvim-treesitter.configs').setup({
  matchup = { enable = true },
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = { ['af'] = '@function.outer', ['if'] = '@function.inner' },
      include_surrounding_whitespace = true,
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = { [']m'] = '@function.outer' },
      goto_previous_start = { ['[m'] = '@function.outer' },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = { ['<leader>df'] = '@function.outer' },
    },
  },
})

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'rounded'
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gd', function()
    require('telescope.builtin').lsp_definitions()
  end, '[G]oto [D]efinition')
  nmap('gD', function()
    require('telescope.builtin').lsp_definitions({ jump_type = 'vsplit' })
    -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  end, '[G]oto [D]efinition Vertically')
  nmap('gr', function()
    require('telescope.builtin').lsp_references({ includeDeclaration = false })
  end, '[G]oto [R]eferences')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols,
    '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    '[W]orkspace [S]ymbols')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  nmap('[d', vim.diagnostic.goto_prev, 'Previous [D]iagnostic')
  nmap(']d', vim.diagnostic.goto_next, 'Next [D]iagnostic')
  nmap('<Leader>dd', vim.diagnostic.open_float, 'Open [D]iagnostic [D]etail')
  nmap('<Leader>dr', vim.diagnostic.reset, '[D]iagnostic [R]eset')
  nmap('<Leader>fd', require('telescope.builtin').diagnostics,
    '[F]ind [D]iagnostics')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<F2>', vim.lsp.buf.rename, 'Rename')
  -- nmap("<F3>", function() vim.lsp.buf.format() end, "Format")
  nmap('ga', vim.lsp.buf.code_action, '[G]oto [A]ction')
  nmap('<leader>wfa', vim.lsp.buf.add_workspace_folder,
    '[W]orkspace [F]older [A]dd')
  nmap('<leader>wfr', vim.lsp.buf.remove_workspace_folder,
    '[W]orkspace [F]older [R]emove')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp
                                                                    .protocol
                                                                    .make_client_capabilities())

local defaultConfig = { on_attach = on_attach, capabilities = capabilities }

require('lspconfig').lua_ls.setup(vim.tbl_extend('force', defaultConfig, {
  settings = {
    Lua = {
      -- format = { enable = false },
      -- completion = { callSnippet = 'Replace' },
      diagnostics = { globals = { 'vim' } },
      -- workspace = { checkThirdParty = false },
      -- telemetry = { enable = false },
    },
  },
}))
-- require('lspconfig').tsserver.setup(defaultConfig)
require('lspconfig').html.setup(defaultConfig)
require('lspconfig').nixd.setup(defaultConfig)
require('lspconfig').hls.setup(defaultConfig)
require('lspconfig').jsonls.setup(defaultConfig)
require('lspconfig').denols.setup(defaultConfig)

require('lspconfig').eslint.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true;
    on_attach(client, bufnr)
  end,
})

require'lspconfig'.aiken.setup{}
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.ak",
  callback = function()
    vim.lsp.buf.format({async = false})
  end
})

require('telescope').load_extension('file_browser')
vim.keymap.set('n', '<leader>fm', function()
  require('telescope').extensions.file_browser.file_browser({
    path = vim.fn.expand('%:p:h'),
    select_buffer = true,
    hidden = true,
  })
end, { noremap = true, desc = '[F]ile [M]anager' })

vim.g.transparent_enabled = true;

require("telescope").setup {
  pickers = {
    buffers = {
      mappings = {
        n = {
          ["<c-d>"] = "delete_buffer",
        }
      }
    }
  }
}
