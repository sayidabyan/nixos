vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.title = true
vim.opt.smartcase = true
vim.opt.clipboard:append({ 'unnamedplus' })
vim.opt.ignorecase = true
vim.opt.hidden = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'

vim.opt.wrap = true
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.mouse = ''

-- string with [ and ] characters are considered as a file path and can be navigated with gf
vim.opt.isfname:append('[')
vim.opt.isfname:append(']')

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
-- TJ
--
-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
--
-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 200

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- https://github.com/neovim/neovim/issues/1936#issuecomment-309311829
-- https://github.com/PhilRunninger/nvim_config/blob/0211c0591bba3621ed6760f8bd437073b6036e08/lua/my-autocmd.lua#L22
vim.opt.autoread = true
local checktimeGroup = vim.api.nvim_create_augroup('checktimeGroup',
                         { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = checktimeGroup,
  command = 'silent! checktime',
})
vim.api.nvim_create_autocmd('CursorHold', {
  group = checktimeGroup,
  command = 'silent! checktime',
})
vim.api.nvim_create_autocmd('CursorMoved', {
  group = checktimeGroup,
  command = 'silent! checktime',
})

local windows = vim.api.nvim_create_augroup('windows', { clear = true })
vim.api.nvim_create_autocmd('VimResized', {
  pattern = { '*' },
  command = 'wincmd =',
  group = windows,
})

local qfgroup = vim.api.nvim_create_augroup('qfgroup', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf' },
  group = qfgroup,
  callback = function()
    vim.keymap.set('n', '<cr>', ':.cc<cr>',
      { buffer = true, desc = 'Go to File' })
    vim.keymap.set('n', '<c-m>', ':.cc<cr>',
      { buffer = true, desc = 'Go to File' })
  end,
})

-- https://github.com/adamtabrams/flatnvim#recommended-skip-exit-prompt-if-terminal-commands-were-successful
local termCloseAutocmd = vim.api.nvim_create_augroup('TermCloseAutocmd',
                           { clear = true })
vim.api.nvim_create_autocmd('TermClose', {
  pattern = '*',
  group = termCloseAutocmd,
  callback = function()
    if vim.v.event.status == 0 then
      vim.cmd('bdelete! ' .. vim.fn.expand('<abuf>'))
    end
  end,
})

vim.keymap.set('n', '<SPACE>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.fn.sign_define('DiagnosticSignError',
  { text = '✖', texthl = 'DiagnosticSignError', numhl = '' })
vim.fn.sign_define('DiagnosticSignWarn',
  { text = '⚠', texthl = 'DiagnosticSignWarn', numhl = '' })
vim.fn.sign_define('DiagnosticSignHint',
  { text = '➤', texthl = 'DiagnosticSignHint', numhl = '' })
vim.fn.sign_define('DiagnosticSignInfo',
  { text = 'ℹ', texthl = 'DiagnosticSignInfo', numhl = '' })

vim.keymap.set('n', '<leader>fo', function()
  vim.fn.jobstart({ 'xdg-open', vim.fn.expand('%') }, { detach = true })
end, { desc = '[F]ile [O]pen' })

-- somehow required because neovim doens't read updated PATH
-- even after setenv
local function which(cmd)
  local stdout = vim.fn.systemlist('which ' .. cmd)
  return table.concat(stdout, '\n')
end

vim.keymap.set('n', '<f3>', function()
  if vim.bo.filetype == 'nix' then
    vim.fn.jobstart({ which('nixpkgs-fmt'), vim.fn.expand('%') })
  end

  if vim.bo.filetype == 'json' then
    vim.fn.jobstart({ which('jq'), '.', vim.fn.expand('%') }, {
      stdout_buffered = true,
      on_stdout = function(_, data, _)
        vim.api.nvim_buf_set_lines(0, 0, -1, false, data)
      end,
    })
  end

  if vim.bo.filetype == 'lua' then
    vim.fn.jobstart({ which('lua-format'), '-i', vim.fn.expand('%') })
  end
end, { desc = 'Format' })

-- window movement
vim.keymap.set('n', '<c-j>', ':wincmd w<cr>', { silent = true })
vim.keymap.set('n', '<c-k>', ':wincmd W<cr>', { silent = true })
vim.keymap.set('n', '<c-h>', ':wincmd <<cr>', { silent = true })
vim.keymap.set('n', '<c-l>', ':wincmd ><cr>', { silent = true })

-- center screen when using <c-u> or <c-d>
vim.keymap.set('n', '<c-d>', '<c-d>zz')
vim.keymap.set('n', '<c-u>', '<c-u>zz')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', 'J', 'mzJ`z')

vim.keymap.set('n', '<leader>s',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Replace word under cursor' })

-- vim.keymap.set('n', '<Leader>tt', ':lcd %:p:h | split term://%:p:h//' .. os.getenv('SHELL') .. ' <CR>',
vim.keymap.set('n', '<Leader>tt',
  ':split term://%:p:h//' .. os.getenv('SHELL') .. ' <CR>',
  { desc = 'Open a [T]erminal in the current directory' })

vim.keymap.set('n', '<Leader>tT',
  ':tabnew term://%:p:h//' .. os.getenv('SHELL') .. ' <CR>',
  { desc = 'Open a [T]erminal in new tab' })

vim.keymap.set('n', '<leader>ht', ':diffthis<Cr>gg<C-w>w:diffthis<Cr>gg',
  { desc = 'Diff two files' })

vim.keymap.set('n', 'yf', ':let @+ = expand("%:p")<cr>',
  { desc = '[Y]ank [F]ile path' })

vim.keymap.set('n', '<c-b>', 'i<CR><ESC>',
  { desc = 'Break line in normal mode' })

vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv',
  { desc = 'Move line down in visual mode' })
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv',
  { desc = 'Move line up in visual mode' })

-- highlight yanked text
local yank_highlight_group = vim.api.nvim_create_augroup('YankHighlight',
                               { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = yank_highlight_group,
  pattern = '*',
})

vim.api.nvim_create_user_command('Clean', function()
  vim.fn.jobstart({ 'kitty', 'nvim', '--clean', vim.fn.expand('%:p') },
    { detach = true })
end, {})
