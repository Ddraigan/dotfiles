return {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    config = function ()
        require('glow').setup({
            style = "dark",
            width_ratio = 0.6,
            height_ratio = 0.8,
            border = "rounded",
        })
    end,
}
