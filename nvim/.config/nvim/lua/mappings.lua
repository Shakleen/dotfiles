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
end, { desc = "Harpoon Toggle quick menu" })
-- harpoon list with harpoon.ui
-- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

map("n", "<leader>a", function()
    harpoon:list():add()
end, { desc = "Harpoon Mark window" })

map("n", "<M-1>", function()
    harpoon:list():select(1)
end, { desc = "Harpoon 1st harpoon marked window" })
map("n", "<M-2>", function()
    harpoon:list():select(2)
end, { desc = "Harpoon 2nd harpoon marked window" })
map("n", "<M-3>", function()
    harpoon:list():select(3)
end, { desc = "Harpoon 3rd harpoon marked window" })
map("n", "<M-4>", function()
    harpoon:list():select(4)
end, { desc = "Harpoon 4th harpoon marked window" })
map("n", "<M-5>", function()
    harpoon:list():select(5)
end, { desc = "Harpoon 5th harpoon marked window" })
map("n", "<M-6>", function()
    harpoon:list():select(6)
end, { desc = "Harpoon 6th harpoon marked window" })
map("n", "<M-7>", function()
    harpoon:list():select(7)
end, { desc = "Harpoon 7th harpoon marked window" })
map("n", "<M-8>", function()
    harpoon:list():select(8)
end, { desc = "Harpoon 8th harpoon marked window" })

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<C-S-P>", function()
    harpoon:list():prev()
end, { desc = "Harpoon previous harpoon marked window" })
map("n", "<C-S-N>", function()
    harpoon:list():next()
end, { desc = "Harpoon next harpoon marked window" })

map("n", "<leader>yf", 'ggVG"+y', { desc = "Copy whole file to system clipboard" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
