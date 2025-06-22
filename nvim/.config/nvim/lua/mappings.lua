require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>wsq", 'ciw""<Esc>P')
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local harpoon = require("harpoon")

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers")
        .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        })
        :find()
end

-- Only one of the following should be active. Either telescope or harpoon.ui
-- Harpoon list with telescope
map("n", "<leader>wh", function()
    toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })
-- harpoon list with harpoon.ui
-- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

map("n", "<leader>a", function()
    harpoon:list():add()
end, { desc = "Mark window for harpoon" })

map("n", "<C-u>", function()
    harpoon:list():select(1)
end, { desc = "Go to 1st harpoon marked window" })
map("n", "<C-i>", function()
    harpoon:list():select(2)
end, { desc = "Go to 2nd harpoon marked window" })
map("n", "<C-o>", function()
    harpoon:list():select(3)
end, { desc = "Go to 3rd harpoon marked window" })
map("n", "<C-p>", function()
    harpoon:list():select(4)
end, { desc = "Go to 4th harpoon marked window" })

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<C-S-P>", function()
    harpoon:list():prev()
end, { desc = "Go to previous harpoon marked window" })
map("n", "<C-S-N>", function()
    harpoon:list():next()
end, { desc = "Go to next harpoon marked window" })
