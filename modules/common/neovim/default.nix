{ ... }:
{
  home-manager.users.sayid = { pkgs, ... }:
    {
      home.packages = with pkgs; [
        wl-clipboard
        file # https://github.com/nvim-telescope/telescope.nvim/pull/224/files
        ripgrep # https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies
        fd # https://github.com/nvim-telescope/telescope.nvim#optional-dependencies
        sops
        nixpkgs-fmt
        luaformatter
        lua-language-server
        nixd
      ];

      programs.neovim.enable = true;
      programs.neovim.viAlias = true;
      programs.neovim.vimAlias = true;
      programs.neovim.vimdiffAlias = true;
      programs.neovim.defaultEditor = true;


      programs.neovim.extraLuaConfig = builtins.readFile ./base.lua + ''
        ${builtins.readFile ./init.lua}
      '';

      programs.neovim.plugins = with pkgs.vimPlugins; [
        cmp-npm
        cmp-nvim-lsp
        cmp-nvim-lsp-document-symbol
        cmp-nvim-lsp-signature-help
        cmp-treesitter
        telescope-file-browser-nvim
        telescope-fzf-native-nvim
        telescope-nvim
        nvim-cmp
        nvim-lspconfig
        nvim-treesitter-textobjects
        nvim-treesitter.withAllGrammars
        lspkind-nvim
        luasnip
        copilot-vim
        editor-integration-nvim

        {
          plugin = lualine-nvim;
          type = "lua";
          config = ''
            require('lualine').setup({
              sections = {
                lualine_c = {
                  {
                    'filename',
                    file_status = true,
                    path = 1, -- Relative path
                  },
                },
              },
            })
          '';
        }
        {
          plugin = winresizer-vim;
          type = "lua";
          config = ''
            vim.keymap.set('n', '<leader>wm', vim.cmd.WinResizerStartMove,
              { desc = '[W]indow [M]ove' })
            vim.keymap.set('n', '<leader>wr', vim.cmd.WinResizerStartResize,
              { desc = '[W]indow [R]esize' })
          '';
        }

        {
          plugin = nvim-autopairs;
          type = "lua";
          config = ''
            require('nvim-autopairs').setup({
              -- https://github.com/windwp/nvim-autopairs#dont-add-pairs-if-it-already-has-a-close-pair-in-the-same-line
              enable_check_bracket_line = false,
            })
          '';
        }

        {
          plugin = direnv-vim;
          type = "lua";
          config = "vim.g.direnv_silent_load = 1";
        }

        {
          plugin = diffview-nvim;
          type = "lua";
          config = ''
            local diffViewActions = require('diffview.actions')

            require('diffview').setup({
              keymaps = {
                file_history_panel = {
                  {
                    'n',
                    '<c-n>',
                    diffViewActions.select_next_entry,
                    { desc = 'Open the diff for the next file' },
                  },
                  {
                    'n',
                    '<c-p>',
                    diffViewActions.select_prev_entry,
                    { desc = 'Open the diff for the previous file' },
                  },
                },
              },
            })
            vim.keymap.set('n', '<leader>gd', vim.cmd.DiffviewOpen,
              { desc = '[G]it [D]iff' })
            vim.keymap.set('n', '<leader>gg', vim.cmd.Git, { desc = '[G]it' })
            vim.keymap.set('n', '<leader>gh', ':DiffviewFileHistory %<CR>',
              { desc = '[G]it File [H]istory' })
            vim.keymap.set('n', '<leader>gH', vim.cmd.DiffviewFileHistory,
              { desc = '[G]it Repo [H]istory' })
          '';
        }

        {
          plugin = harpoon;
          type = "lua";
          config = ''
                      vim.api.nvim_set_hl(0, 'HarpoonWindow', { link = 'Normal' })
                      vim.api.nvim_set_hl(0, 'HarpoonBorder', { link = 'Normal' })

                      vim.keymap.set('n', '<leader>ha', require('harpoon.mark').add_file,
                        { desc = '[H]arpoon [A]dd File' })
                      vim.keymap.set('n', '<leader>hm', require('harpoon.ui').toggle_quick_menu,
                        { desc = '[H]arpoon Toggle' })
                      vim.keymap.set('n', '<C-m>', function()
                        require('harpoon.ui').nav_file(1)
                      end, { desc = 'Harpoon Navigate To File 1' })
                      vim.keymap.set('n', '<C-,>', function()
                        require('harpoon.ui').nav_file(2)
                      end, { desc = 'Harpoon Navigate To File 2' })
                      vim.keymap.set('n', '<C-.>', function()
                        require('harpoon.ui').nav_file(3)
                      end, { desc = 'Harpoon Navigate To File 3' })
                      vim.keymap.set('n', '<C-/>', function()
                        require('harpoon.ui').nav_file(4)
                      end, { desc = 'Harpoon Navigate To File 4' })
                      vim.keymap.set('n', '<leader>hl', function()
                        require('harpoon.ui').nav_next()
                      end, {desc = 'Harpoon Navigate To Next File'})
            	        vim.keymap.set('n', '<leader>hh', function()
                        require('harpoon.ui').nav_prev()
                      end, {desc = 'Harpoon Navigate to next File'})
          '';
        }

        {
          plugin = catppuccin-nvim;
          type = "lua";
          config = ''
            vim.cmd('colorscheme catppuccin-mocha')
          '';
        }
        {
          plugin = transparent-nvim;
          type = "lua";
          config = ''
            require("transparent").setup({
              extra_groups = {
                "TelescopeNormal",
                "TelescopeBorder",
                "TelescopePromptBorder",
                "TelescopePromptTitle",
              };
            })
          '';
        }

        {
          plugin = dressing-nvim;
          type = "lua";
          config = "require('dressing').setup({ input = { insert_only = false, winblend = 0 } })";
        }

        {
          plugin = fidget-nvim;
          type = "lua";
          config = ''
            require('fidget').setup({
              notification = {
                window = {
                  winblend = 0,
                },
              },
            })
          '';
        }

        {
          plugin = gitsigns-nvim;
          type = "lua";
          config = ''
            require('gitsigns').setup({
              preview_config = { border = 'rounded' },
              signs = { add = { text = '+' }, change = { text = '~' } },
              on_attach = function(bufnr)
                vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
                vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Normal' })

                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                  opts = opts or {}
                  opts.buffer = bufnr
                  vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                  if vim.wo.diff then
                    return ']c'
                  end
                  vim.schedule(gs.next_hunk)
                  return '<Ignore>'
                end, { expr = true, desc = 'Next Hunk' })

                map('n', '[c', function()
                  if vim.wo.diff then
                    return '[c'
                  end
                  vim.schedule(gs.prev_hunk)
                  return '<Ignore>'
                end, { expr = true, desc = 'Previous Hunk' })

                -- Actions
                map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, { desc = '[H]unk [S]tage' })
                map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, { desc = '[H]unk [R]eset' })
                map('n', '<leader>hS', gs.stage_buffer, { desc = '[H]unk [S]tage Buffer' })
                map('n', '<leader>hR', gs.reset_buffer, { desc = '[H]unk [R]eset Buffer' })
                map('n', '<leader>hu', gs.undo_stage_hunk, { desc = '[H]unk [U]ndo Stage' })
                map('n', '<leader>hp', gs.preview_hunk, { desc = '[H]unk [P]review' })
                map('n', '<leader>hb', function()
                  gs.blame_line({ full = true })
                end, { desc = '[H]unk [B]lame' })
                map('n', '<leader>tb', gs.toggle_current_line_blame,
                  { desc = '[T]oggle [B]lame' })
                map('n', '<leader>td', gs.toggle_deleted, { desc = '[T]oggle [D]eleted' })

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>',
                  { desc = '[I]n [H]unk' })
              end,
            })
          '';
        }
        {
          plugin = vim-auto-save;
          type = "lua";
          config = ''
            vim.g.auto_save = 1
            vim.g.auto_save_silent = 1
          '';
        }
        {
          plugin = toggleterm-nvim;
          type = "lua";
          config = ''
            require("toggleterm").setup({
              direction = 'float',
              open_mapping = [[<C-t>]]
            })
          '';
        }
        {
          plugin = trouble-nvim;
          type = "lua";
          config = ''
            local trouble = require('trouble')

            trouble.setup {}

            vim.keymap.set('n', '<leader>xx', function()
            trouble.open()
            end, { desc = 'Trouble open' });
            vim.keymap.set('n', '<leader>xw', function()
            trouble.open('workspace_diagnostics')
            end, { desc = 'Trouble open workspace diagnostics' })
            vim.keymap.set('n', '<leader>xd', function()
            trouble.open('document_diagnostics')
            end, { desc = 'Trouble open document diagnostics' })
            vim.keymap.set('n', '<leader>xq', function()
            trouble.open('quickfix')
            end, { desc = 'Trouble open quickfix' })
            vim.keymap.set('n', '<leader>xl', function()
            trouble.open('loclist')
            end, { desc = 'Trouble open loclist' })
            vim.keymap.set('n', 'gR', function()
            trouble.open('lsp_references')
            end, { desc = 'Trouble open lsp references' })
          '';
        }

        {
          plugin = term-edit-nvim;
          config = "require ('term-edit').setup ({ prompt_end = '> ' })";
          type = "lua";
        }

        {
          plugin = leap-nvim;
          config = "require('leap').add_default_mappings()";
          type = "lua";
        }

        {
          plugin = comment-nvim;
          config = "require('Comment').setup()";
          type = "lua";
        }

        {
          plugin = which-key-nvim;
          config = "require('which-key').setup()";
          type = "lua";
        }

        {
          plugin = nvim-lastplace;
          config = "require('nvim-lastplace')";
          type = "lua";
        }

        {
          plugin = nvim-pqf;
          config = "require('pqf').setup()";
          type = "lua";
        }

        {
          plugin = nvim-surround;
          config = "require('nvim-surround').setup()";
          type = "lua";
        }
      ];
    };
}
