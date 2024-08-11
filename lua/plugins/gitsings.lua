-- git signs highlights text that has changed since the list
-- git commit, and also lets you interactively stage & unstage
-- hunks in a commit.
return {
    "lewis6991/gitsigns.nvim",
    event = "VimEnter",
    opts = {
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = "." },
        },
        signs_staged = {
            add = { text = " ▎" },
            change = { text = " ▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = " ." },
        },
        watch_gitdir = {
            follow_files = true
        },
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end

            -- stylua: ignore start
            map("n", "]h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gs.nav_hunk("next")
                end
            end, "Next Hunk")
            map("n", "[h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gs.nav_hunk("prev")
                end
            end, "Prev Hunk")
            map("n", "<leader>ghn", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gs.nav_hunk("next")
                end
            end, "Next Hunk")
            map("n", "<leader>ghp", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gs.nav_hunk("prev")
                end
            end, "Prev Hunk")
            map("n", "]H", function() gs.nav_hunk("last") end, "Last [H]unk")
            map("n", "[H", function() gs.nav_hunk("first") end, "First [H]unk")
            map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "[G]it [H]unk [R]eset")
            map("n", "<leader>ghR", gs.reset_buffer, "[G]it [H]unk [R]eset Buffer")
            map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "[G]it [H]unk [S]tage")
            map("n", "<leader>ghS", gs.stage_buffer, "[G]it [H]unk [S]tage Buffer")
            map("n", "<leader>ghu", gs.undo_stage_hunk, "[G]it [H]unk [U]nstage")
            map("n", "<leader>ghU", gs.reset_buffer_index, "[G]it [H]unk [U]nstage Buffer")
            map("n", "<leader>ghp", gs.preview_hunk_inline, "[G]it [H]unk [P]review Inline")
            map("n", "<leader>ghd", gs.diffthis, "[G]it [H]unk [D]iff This")
            map("n", "<leader>ghD", function() gs.diffthis("~") end, "[G]it [H]unk [D]iff This ~")
            map("n", "<leader>gbl", function() gs.blame_line({ full = true }) end, "[G]it [B]lame [L]ine")
            map("n", "<leader>gbb", function() gs.blame() end, "[G]it [B]lame [B]uffer")
            map("n", "<leader>gbt", gs.toggle_current_line_blame, "[G]it [B]lame [T]oggle")
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end,
    },
}
