return { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
        require('which-key').setup()

        -- Document existing key chains
        require('which-key').add {
            { '<leader>c', group = '[C]ode', mode = { 'n', 'v' }, icon = {icon = '', color = 'orange'} },
            { '<leader>s', group = '[S]earch', mode = { 'n', 'v' }, icon = {icon = '', color = 'blue'} },
            { "<leader>f", group = "[F]ile/find", icon = {icon = '', color = 'orange'} },
            { "<c-w>", group = "[W]indows", icon = {icon = '', color = 'blue'} },
            { '<leader>w', proxy = '<c-w>', group = '[W]indows', icon = {icon = '', color = 'blue'} }, -- proxy to window mappings
            { '<leader>b', group = '[B]uffer', icon = {icon = '', olor = 'orange' }},
            { '<leader>g', group = '[G]it', icon = {icon = '󰊢', color = 'orange'} },
            { "<leader>gh", group = "[G]it [H]unks" },
            { '<leader>x', group = '[X] Diagnostics/Quickfix', icon = {icon = '󱖫', color = 'cyan' }},
            { '<leader>u', group = '[U]i', icon = {icon = "󰙵 ", color = "cyan"} },
            { '<leader><tab>', group = 'Tabs' },
            { "<leader>q", group = "[Q]uit/session" },
            { "[", group = "prev" },
            { "]", group = "next" },
            { "g", group = "goto" },
            { "gs", group = "surround" },
            { "z", group = "fold" },
            {
                "<leader>b",
                group = "buffer",
                expand = function()
                    return require("which-key.extras").expand.buf()
                end,
            },
            {
                "<leader>w",
                group = "windows",
                proxy = "<c-w>",
                expand = function()
                    return require("which-key.extras").expand.win()
                end,
            },
            -- better descriptions
            { "gx", desc = "Open with system app" },
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Keymaps (which-key)",
            },
            {
                "<c-w><space>",
                function()
                    require("which-key").show({ keys = "<c-w>", loop = true })
                end,
                desc = "Window Hydra Mode (which-key)",
            },
        }

        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            if not vim.tbl_isempty(opts.defaults) then
                LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
                wk.register(opts.defaults)
            end
        end
    end
}

