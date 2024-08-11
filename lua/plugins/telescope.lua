-- See `:help telescope.builtin`
-- local builtin = require 'telescope.builtin'

--         -- Slightly advanced example of overriding default behavior and theme
--         vim.keymap.set('n', '<leader>/', function()
--             -- You can pass additional configuration to Telescope to change the theme, layout, etc.
--             builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--                 winblend = 10,
--                 previewer = false,
--             })
--         end, { desc = '[/] Fuzzily search in current buffer' })
--
--         -- It's also possible to pass additional configuration options.
--         --  See `:help telescope.builtin.live_grep()` for information about particular keys
--         vim.keymap.set('n', '<leader>s/', function()
--             builtin.live_grep {
--                 grep_open_files = true,
--                 prompt_title = 'Live Grep in Open Files',
--             }
--         end, { desc = '[S]earch [/] in Open Files' })
--
--         -- Shortcut for searching your Neovim configuration files
--         vim.keymap.set('n', '<leader>sn', function()
--             builtin.find_files { cwd = vim.fn.stdpath 'config' }
--         end, { desc = '[S]earch [N]eovim files' })
--     end,
-- }

return {
  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    -- enabled = function()
    --   return LazyVim.pick.want() == "telescope"
    -- end,
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      {
        'nvim-lua/plenary.nvim',
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
            'nvim-telescope/telescope-fzf-native.nvim',

            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = 'make',

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
      },
    },
    require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
            ['ui-select'] = {
                require('telescope.themes').get_dropdown(),
            },
        },
    },
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      -- git
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Find [G]it [F]iles" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "[G]it [C]ommits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "[G]it [S]tatus" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "[S]earch [R]egisters" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "[S]earch [A]uto Commands" },
      { "<leader>sb", "<cmd>Telescope builtin<cr>", desc = "[S]earch [B]uiltin" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "[S]earch [C]ommand History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "[S]earch [C]ommands" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "[S]earch [H]ighlight Groups" },
      { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "[S]earch [J]umplist" },
      { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "[S]earch [L]ocation List" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "[S]earch [M]an Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "[S]earch [M]ark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "[S]earch [O]ptions" },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "[S]earch [Q]uickfix List" },
      { '<leader>sh', "<cmd>Telescope help_tags<cr>", desc = '[S]earch [H]elp'},
      { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = '[S]earch [K]eymaps' },
      { '<leader>sf', '<cmd>Telescope find_files<cr>', desc = '[S]earch [F]iles' },
      { '<leader>ss', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = '[S]earch [S]trings in the buffer' },
      { '<leader>sw', '<cmd>Telescope grep_string<cr>', desc = '[S]earch current [W]ord' },
      { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = '[S]earch by [G]rep' },
      { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = '[S]earch [D]iagnostics' },
      { '<leader>sr', '<cmd>Telescope resume<cr>', desc = '[S]earch [R]esume' },
      { '<leader>s.', '<cmd>Telescope oldfiles<cr>', desc = '[S]earch Recent Files ("." for repeat)' },
      { '<leader>sw', '<cmd>Telescope grep_string<cr>', mode = "v", desc = '[S]earch selected [W]ords' },
      -- FIXME: lsp config
      -- {
      --   "<leader>ss",
      --   function()
      --     require("telescope.builtin").lsp_document_symbols({
      --       symbols = LazyVim.config.get_kind_filter(),
      --     })
      --   end,
      --   desc = "Goto Symbol",
      -- },
      -- {
      --   "<leader>sS",
      --   function()
      --     require("telescope.builtin").lsp_dynamic_workspace_symbols({
      --       symbols = LazyVim.config.get_kind_filter(),
      --     })
      --   end,
      --   desc = "Goto Symbol (Workspace)",
      -- },
    },
    opts = function()
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      local actions = require("telescope.actions")

      local open_with_trouble = function(...)
        return require("trouble.sources.telescope").open(...)
      end
      -- local find_files_no_ignore = function()
      --   local action_state = require("telescope.actions.state")
      --   local line = action_state.get_current_line()
      --   LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
      -- end
      -- local find_files_with_hidden = function()
      --   local action_state = require("telescope.actions.state")
      --   local line = action_state.get_current_line()
      --   LazyVim.pick("find_files", { hidden = true, default_text = line })()
      -- end

      local function find_command()
        if 1 == vim.fn.executable("rg") then
          return { "rg", "--files", "--color", "never", "-g", "!.git" }
        elseif 1 == vim.fn.executable("fd") then
          return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
        elseif 1 == vim.fn.executable("fdfind") then
          return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
        elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
          return { "find", ".", "-type", "f" }
        elseif 1 == vim.fn.executable("where") then
          return { "where", "/r", ".", "*" }
        end
      end

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          -- FIXME: 
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              -- ["<c-t>"] = open_with_trouble,
              -- ["<a-t>"] = open_with_trouble,
              ["<a-i>"] = find_files_no_ignore,
              ["<a-h>"] = find_files_with_hidden,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = find_command,
            hidden = true,
          },
        },
      }
    end,
  },

  -- -- Flash Telescope config
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     if not LazyVim.has("flash.nvim") then
  --       return
  --     end
  --     local function flash(prompt_bufnr)
  --       require("flash").jump({
  --         pattern = "^",
  --         label = { after = { 0, 0 } },
  --         search = {
  --           mode = "search",
  --           exclude = {
  --             function(win)
  --               return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
  --             end,
  --           },
  --         },
  --         action = function(match)
  --           local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  --           picker:set_selection(match.pos[1] - 1)
  --         end,
  --       })
  --     end
  --     opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
  --       mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
  --     })
  --   end,
  -- },

  -- better vim.ui with telescope
  {
    "stevearc/dressing.nvim",
    lazy = true,
    -- enabled = function()
    --   return LazyVim.pick.want() == "telescope"
    -- end,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  --
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function()
  --     -- if LazyVim.pick.want() ~= "telescope" then
  --     --   return
  --     -- end
  --     -- local Keys = require("lazyvim.plugins.lsp.keymaps").get()
  --     -- stylua: ignore
  --     vim.list_extend(Keys, {
  --       { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
  --       { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
  --       { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
  --       { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
  --     })
  --   end,
  -- },
}
