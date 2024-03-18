return {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    main = "ibl",
    config = function ()
        -- local colour = require("config.theme").soft

        -- local highlight = {
        --     "RainbowRed",
        --     "RainbowYellow",
        --     "RainbowBlue",
        --     "RainbowOrange",
        --     "RainbowGreen",
        --     "RainbowViolet",
        --     "RainbowCyan",
        -- }

        -- local hooks = require "ibl.hooks"
        -- -- create the highlight groups in the highlight setup hook, so they are reset
        -- -- every time the colorscheme changes
        -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function ()
        --     vim.api.nvim_set_hl(0, "RainbowRed", { fg = colour.bright_red })
        --     vim.api.nvim_set_hl(0, "RainbowYellow", { fg = colour.bright_yellow })
        --     vim.api.nvim_set_hl(0, "RainbowBlue", { fg = colour.bright_blue })
        --     vim.api.nvim_set_hl(0, "RainbowOrange", { fg = colour.orange })
        --     vim.api.nvim_set_hl(0, "RainbowGreen", { fg = colour.bright_green })
        --     vim.api.nvim_set_hl(0, "RainbowViolet", { fg = colour.bright_magenta })
        --     vim.api.nvim_set_hl(0, "RainbowCyan", { fg = colour.bright_cyan })
        -- end)

        require("ibl").setup({
            -- scope = { enabled = true },
            -- indent = { highlight = "BrightGreen" },
            indent = {
                -- highlight = highlight,
                char = "┊",
                tab_char = "┊",
                smart_indent_cap = true,
            },
            whitespace = {
                remove_blankline_trail = true,
            },
        })
    end,
}
