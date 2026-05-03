return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup({
        settings = {
          save_on_toggle = true,
        },
      })
    end,
  },
  {
    "letieu/harpoon-lualine",
    dependencies = {
      "nvim-lualine/lualine.nvim",
      {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
      },
    },
  },
}
