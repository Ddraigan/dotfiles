return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function ()
        local HEIGHT_RATIO = 0.8
        local WIDTH_RATIO = 0.6

        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)

        require("oil").setup({
            float = {
                -- Padding around the floating window
                padding = 2,
                max_width = window_w_int,
                max_height = window_h_int,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
            },
            keymaps = {
                ["q"] = "actions.close",
            },
            view_options = {
                show_hidden = true,
            },
        })
    end,
}
