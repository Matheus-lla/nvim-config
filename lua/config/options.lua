-------------------------------------------------------------------
---                          Vim.opts                           ---
---                     See `:help vim.opt`                     ---
-------------------------------------------------------------------
---                          Globals                            ---
-------------------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- LazyVim auto format
vim.g.autoformat = true

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-------------------------------------------------------------------
---                          Options                            ---
-------------------------------------------------------------------
local opt = vim.opt

-- Set tab width to 4 spaces
opt.tabstop = 4         -- A TAB character looks like 4 spaces
opt.expandtab = true    -- Pressing the TAB key will insert spaces instead of a TAB character
opt.softtabstop = 4     -- Number of spaces inserted instead of a TAB character
opt.shiftwidth = 4      -- Number of spaces inserted when indenting

-- Make line numbers and relative line number default
opt.number = true
opt.relativenumber = true

-- Dont wrap when the line is to long
vim.o.wrap = false

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines and columns to keep around the cursor.
opt.scrolloff = 10
opt.sidescrolloff = 8

-- Auto complete of commands
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer

-- Fold options
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldlevel = 99

-- opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
-- opt.formatoptions = "jcroqlnt" -- tcqj
-- opt.grepformat = "%f:%l:%c:%m"

-- Set the minimum width for a window
opt.winminwidth = 5

-- Use ripgrep (rg) for the grep command in Vim, with vimgrep format
opt.grepprg = "rg --vimgrep"

-- Save and restore view settings (e.g., folds) when jumping
opt.jumpoptions = "view"

-- Always display a global status line
opt.laststatus = 3

-- Wrap lines at word boundaries instead of in the middle of words
opt.linebreak = true

-- Set the transparency level for the popup menu
opt.pumblend = 10

-- Set the maximum number of items to show in the popup menu
opt.pumheight = 10

-- Options to save and restore in a session
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Round indent to the nearest shiftwidth multiple
opt.shiftround = true

-- Suppress various messages (e.g., startup, file written, completion)
opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Automatically insert indents in a smart way when starting a new line
opt.smartindent = true

-- Set the spell-checking language to English
opt.spelllang = { "en" }

-- Don't spell-check plain text buffers by default
opt.spelloptions:append("noplainbuffer")

-- Keep the screen layout consistent when splitting windows
opt.splitkeep = "screen"

-- Custom status column, currently commented out
-- opt.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]

-- Enable true color support in the terminal
opt.termguicolors = true

-- Set the maximum number of undo levels
opt.undolevels = 10000

-- Allow cursor movement in areas with no text in visual block mode
opt.virtualedit = "block"

-- Command-line completion: complete to longest match, then full list
opt.wildmode = "longest:full,full"

-- Enable true color support in the terminal
opt.termguicolors = true

-- Set the maximum number of undo levels
opt.undolevels = 10000

-- Allow cursor movement in areas with no text in visual block mode
opt.virtualedit = "block"

-- Command-line completion: complete to longest match, then full list
opt.wildmode = "longest:full,full"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Sync clipboard between OS and Neo
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    opt.clipboard = 'unnamedplus'
end)
-- Function to enable wsl clipboard
if vim.fn.has 'wsl' == 1 then
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

