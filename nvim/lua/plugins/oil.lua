return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
        keymaps = {
            ["q"] = "actions.close",
        },
        view_options = {
            show_hidden = true,
        },
    },
    config = function ()
        require("oil").setup()
    end,
}
