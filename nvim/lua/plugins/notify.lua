return {
  "rcarriga/nvim-notify",
  event = "BufReadPre",
  keys = {
    {
      "<leader>nd",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss all Notifications",
    },
  },
  opts = {
    background_colour = "#000000",
    timeout = 10000,
    stages = "static",
    render = "compact",
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  },
}
