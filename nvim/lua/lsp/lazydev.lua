return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
  },
}

-- Additional Lua configuration
-- return {
-- 	"folke/neodev.nvim",
-- 	config = function()
-- 		require("neodev").setup({
-- 			library = {
-- 				plugins = true,
-- 				types = true,
-- 			},
-- 		})
-- 	end,
-- }
