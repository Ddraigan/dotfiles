return {
  "carbon-steel/detour.nvim",
  event = "VeryLazy",
  config = function ()
    vim.keymap.set("n", "<c-w><enter>", ":Detour<cr>")
    vim.keymap.set("n", "<c-w>.", ":DetourCurrentWindow<cr>")
    vim.keymap.set("n", "<leader>sd", function ()
      local ok = require("detour").Detour() -- Open a detour popup
      if not ok then
        return
      end

      local current_buffer_name = vim.api.nvim_buf_get_name(0)

      vim.cmd.terminal("diff-tool " .. current_buffer_name) -- Open terminal buffer
      vim.bo.bufhidden = "delete"                           -- Close the terminal when window closes

      -- It's common for people to have `<Esc>` mapped to `<C-\><C-n>` for terminals.
      -- This can get in the way when interacting with TUIs.
      -- This maps the escape key back to itself (for this buffer) to fix this problem.
      vim.keymap.set('t', '<Esc>', '<Esc>', { buffer = true })

      vim.cmd.startinsert() -- Go into insert mode


      vim.api.nvim_create_autocmd({ "TermClose" }, {
        buffer = vim.api.nvim_get_current_buf(),
        callback = function ()
          -- This automated keypress skips the "[Process exited 0]" message
          vim.api.nvim_feedkeys('i', 'n', false)
        end
      })
    end)
  end,
}
