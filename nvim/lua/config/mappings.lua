vim.g.mapleader = " " -- Set <space> as leader key
vim.keymap.set("n", "<leader>-", vim.cmd.Ex)

local mappings = require("keymap").general
for mode, values in pairs(mappings) do
    for keybind, mapping_info in pairs(values) do
        local opts = {
            desc = mapping_info[2]
        }
        vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
end
