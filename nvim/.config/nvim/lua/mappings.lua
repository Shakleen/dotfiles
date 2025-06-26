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

-- Helper function to create the finder based on the current harpoon list
local function create_harpoon_finder()
    local harpoon_items = harpoon:list().items
    local file_paths = {}
    for _, item in ipairs(harpoon_items) do
        table.insert(file_paths, item.value)
    end
    return require("telescope.finders").new_table({
        results = file_paths,
    })
end

local function toggle_telescope()
    require("telescope.pickers")
        .new({}, {
            prompt_title = "Harpoon",
            finder = create_harpoon_finder(), -- Use the helper function here
            previewer = false,
            sorter = conf.generic_sorter({}),
            layout_strategy = "center",
            layout_config = {
                preview_cutoff = 1,
                width = function(_, max_columns, _)
                    return math.min(max_columns, 80)
                end,
                height = function(_, _, max_lines)
                    return math.min(max_lines, 15)
                end,
            },
            borderchars = {
                prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
                results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
                preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            },
            attach_mappings = function(prompt_buffer_number, map)
                -- The keymap you need
                map("i", "<C-d>", function()
                    local state = require("telescope.actions.state")
                    local selected_entry = state.get_selected_entry()
                    local current_picker = state.get_current_picker(prompt_buffer_number)

                    -- This is the line you need to remove the entry
                    harpoon:list():remove(selected_entry)
                    current_picker:refresh(create_harpoon_finder()) -- Refresh with the updated finder
                end)

                return true
            end,
        })
        :find()
end

-- Only one of the following should be active. Either telescope or harpoon.ui
-- Harpoon list with telescope
map("n", "<leader>wh", function()
    toggle_telescope()
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
