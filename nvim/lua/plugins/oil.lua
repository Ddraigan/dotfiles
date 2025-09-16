return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = function()
    local HEIGHT_RATIO = 0.8
    local WIDTH_RATIO = 0.6

    local screen_w = vim.opt.columns:get()
    local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
    local window_w = screen_w * WIDTH_RATIO
    local window_h = screen_h * HEIGHT_RATIO
    local window_w_int = math.floor(window_w)
    local window_h_int = math.floor(window_h)

    local detail = false

    function _G.get_oil_winbar()
      local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
      local dir = require("oil").get_current_dir(bufnr)
      if dir then
        return vim.fn.fnamemodify(dir, ":~")
      else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
      end
    end

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
        ["gd"] = {
          desc = "Toggle file details",
          callback = function()
            detail = not detail
            if detail then
              require("oil").set_columns({
                { "icon" },
                { "permissions", highlight = "Special" },
                { "size", highlight = "Comment" },
                { "mtime", highlight = "Special" },
                { "birthtime", highlight = "Comment" },
              })
            else
              require("oil").set_columns({ "icon" })
            end
          end,
        },
      },
      view_options = {
        show_hidden = true,
      },
      win_options = {
        winbar = "%!v:lua.get_oil_winbar()",
      },
    })
  end,
}
