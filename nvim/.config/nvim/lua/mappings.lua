require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>wsq", 'ciw""<Esc>P')
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local harpoon = require("harpoon")

-- Only one of the following should be active. Either telescope or harpoon.ui
-- Harpoon list with telescope
map("n", "<leader>wh", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open harpoon window" })
-- harpoon list with harpoon.ui
-- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

map("n", "<leader>a", function()
    harpoon:list():add()
end, { desc = "Mark window for harpoon" })

map("n", "<M-1>", function()
    harpoon:list():select(1)
end, { desc = "Go to 1st harpoon marked window" })
map("n", "<M-2>", function()
    harpoon:list():select(2)
end, { desc = "Go to 2nd harpoon marked window" })
map("n", "<M-3>", function()
    harpoon:list():select(3)
end, { desc = "Go to 3rd harpoon marked window" })
map("n", "<M-4>", function()
    harpoon:list():select(4)
end, { desc = "Go to 4th harpoon marked window" })
map("n", "<M-5>", function()
    harpoon:list():select(5)
end, { desc = "Go to 5th harpoon marked window" })
map("n", "<M-6>", function()
    harpoon:list():select(6)
end, { desc = "Go to 6th harpoon marked window" })
map("n", "<M-7>", function()
    harpoon:list():select(7)
end, { desc = "Go to 7th harpoon marked window" })
map("n", "<M-8>", function()
    harpoon:list():select(8)
end, { desc = "Go to 8th harpoon marked window" })

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<C-S-P>", function()
    harpoon:list():prev()
end, { desc = "Go to previous harpoon marked window" })
map("n", "<C-S-N>", function()
    harpoon:list():next()
end, { desc = "Go to next harpoon marked window" })
