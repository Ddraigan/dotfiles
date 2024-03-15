return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function ()
        -- local api = require("nvim-tree.api")
        --
        -- local function edit_or_open()
        --     local node = api.tree.get_node_under_cursor()
        --
        --     if node.nodes ~= nil then
        --         -- expand or collapse folder
        --         api.node.open.edit()
        --     else
        --         -- open file
        --         api.node.open.edit()
        --         -- Close the tree if file was opened
        --         api.tree.close()
        --     end
        -- end
        --
        -- vim.keymap.set("n", "<enter>", edit_or_open)

        local HEIGHT_RATIO = 0.8
        local WIDTH_RATIO = 0.5
        local api = require("nvim-tree.api")

        require("nvim-tree").setup({
            disable_netrw = true,
            hijack_netrw = true,
            hijack_cursor = true,
            hijack_unnamed_buffer_when_opening = false,
            -- open_on_setup = true,
            on_attach = function ()
                vim.keymap.set("n", "<leader>-", "<cmd> noautocmd lua require('nvim-tree.api').tree.toggle() <CR>")
                vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node)
                vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer)
                vim.keymap.set("n", "<C-k>", api.node.show_info_popup)
                vim.keymap.set("n", "<C-r>", api.fs.rename_sub)
                vim.keymap.set("n", "<C-t>", api.node.open.tab)
                vim.keymap.set("n", "<C-v>", api.node.open.vertical)
                vim.keymap.set("n", "<C-x>", api.node.open.horizontal)
                vim.keymap.set("n", "<BS>", api.node.navigate.parent_close)
                vim.keymap.set("n", "<CR>", api.node.open.edit)
                vim.keymap.set("n", "<Tab>", api.node.open.preview)
                vim.keymap.set("n", ">", api.node.navigate.sibling.next)
                vim.keymap.set("n", "<", api.node.navigate.sibling.prev)
                vim.keymap.set("n", ".", api.node.run.cmd)
                vim.keymap.set("n", "-", api.tree.change_root_to_parent)
                vim.keymap.set("n", "a", api.fs.create)
                vim.keymap.set("n", "bmv", api.marks.bulk.move)
                vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter)
                vim.keymap.set("n", "c", api.fs.copy.node)
                vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter)
                vim.keymap.set("n", "[c", api.node.navigate.git.prev)
                vim.keymap.set("n", "]c", api.node.navigate.git.next)
                vim.keymap.set("n", "d", api.fs.remove)
                vim.keymap.set("n", "D", api.fs.trash)
                vim.keymap.set("n", "E", api.tree.expand_all)
                vim.keymap.set("n", "e", api.fs.rename_basename)
                vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next)
                vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev)
                vim.keymap.set("n", "F", api.live_filter.clear)
                vim.keymap.set("n", "f", api.live_filter.start)
                vim.keymap.set("n", "g?", api.tree.toggle_help)
                vim.keymap.set("n", "gy", api.fs.copy.absolute_path)
                vim.keymap.set("n", "H", api.tree.toggle_hidden_filter)
                vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter)
                vim.keymap.set("n", "J", api.node.navigate.sibling.last)
                vim.keymap.set("n", "K", api.node.navigate.sibling.first)
                vim.keymap.set("n", "m", api.marks.toggle)
                vim.keymap.set("n", "o", api.node.open.edit)
                vim.keymap.set("n", "O", api.node.open.no_window_picker)
                vim.keymap.set("n", "p", api.fs.paste)
                vim.keymap.set("n", "P", api.node.navigate.parent)
                vim.keymap.set("n", "q", api.tree.close)
                vim.keymap.set("n", "r", api.fs.rename)
                vim.keymap.set("n", "R", api.tree.reload)
                vim.keymap.set("n", "s", api.node.run.system)
                vim.keymap.set("n", "S", api.tree.search_node)
                vim.keymap.set("n", "U", api.tree.toggle_custom_filter)
                vim.keymap.set("n", "W", api.tree.collapse_all)
                vim.keymap.set("n", "x", api.fs.cut)
                vim.keymap.set("n", "y", api.fs.copy.filename)
                vim.keymap.set("n", "Y", api.fs.copy.relative_path)
                vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit)
                vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node)
            end,
            hijack_directories = { enable = true, auto_open = true },
            sync_root_with_cwd = true,
            filters = { dotfiles = false },
            -- view = {
            --     float = {
            --         enable = true,
            --         open_win_config = function ()
            --             local screen_w = vim.opt.columns:get()
            --             local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            --             local window_w = screen_w * WIDTH_RATIO
            --             local window_h = screen_h * HEIGHT_RATIO
            --             local window_w_int = math.floor(window_w)
            --             local window_h_int = math.floor(window_h)
            --             local center_x = (screen_w - window_w) / 2
            --             local center_y = ((vim.opt.lines:get() - window_h) / 2)
            --                 - vim.opt.cmdheight:get()
            --             return {
            --                 border = 'rounded',
            --                 relative = 'editor',
            --                 row = center_y,
            --                 col = center_x,
            --                 width = window_w_int,
            --                 height = window_h_int,
            --             }
            --         end,
            --     },
            --     width = function ()
            --         return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
            --     end,
            -- },
        })
    end,
}
