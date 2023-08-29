vim.g.mapleader = " " -- Set <space> as leader key
vim.keymap.set("n", "<leader>-", vim.cmd.Ex)

-- Trouble Plugin
vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)

local mappings = require("keymap").general
for mode, values in pairs(mappings) do
    for keybind, mapping_info in pairs(values) do
        local opts = {
            desc = mapping_info[2]
        }
        vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
end
