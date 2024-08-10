return {
    'sainnhe/gruvbox-material',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
        vim.g.gruvbox_material_background = 'hard'
        vim.g.gruvbox_material_foreground = 'original'
        vim.g.gruvbox_material_enable_italic = false
        vim.cmd.colorscheme 'gruvbox-material'
        vim.cmd.hi 'Comment gui=none'
    end
}

