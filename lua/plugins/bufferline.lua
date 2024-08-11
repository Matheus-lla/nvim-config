-- This is what powers LazyVim's fancy-looking
-- tabs, which include filetype icons and close buttons.
return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "[B]uffer toggle [P]in" },
        { "<leader>bn", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "[B]uffer delete [N]on-Pinned buffers" },
        { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "[B]uffer delete Other" },
        { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "[B]uffer delete to the [R]ight" },
        { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "[B]uffer Delete to the [L]eft" },
        { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev [B]uffer" },
        { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next [B]uffer" },
        { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev [B]uffer" },
        { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next [B]uffer" },
        { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move [B]uffer prev" },
        { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move [B]uffer next" },
    },
    opts = {
        options = {
            -- stylua: ignore
            close_command = function(n) LazyVim.ui.bufremove(n) end,
            -- stylua: ignore
            right_mouse_command = function(n) LazyVim.ui.bufremove(n) end,
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            separator_style = "slant",
            indicator = { style = 'underline' },
            highlight = { underline = true, sp = "red"}, -- Optional
            highlights = {
                tab_separator_selected = {
                    underline = '9',
                },
            },
            diagnostics_indicator = function(_, _, diag)
                local icons = LazyVim.config.icons.diagnostics
                local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                .. (diag.warning and icons.Warn .. diag.warning or "")
                return vim.trim(ret)
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
            ---@param opts bufferline.IconFetcherOpts
            get_element_icon = function(opts)
                return LazyVim.config.icons.ft[opts.filetype]
            end,
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)
        -- Fix bufferline when restoring a session
        vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
            callback = function()
                vim.schedule(function()
                    pcall(nvim_bufferline)
                end)
            end,
        })
    end
}
