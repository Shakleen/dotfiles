-- Original config lines start from here
-- require("nvchad.configs.lspconfig").defaults()

-- local servers = { "html", "cssls" }
-- vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- list of all servers configured.
lspconfig.servers = {
    "gopls",
    "ltex_plus",
    "lua_ls",
    "pyright",
}

-- list of servers configured with default config.
local default_servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(default_servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
end

lspconfig.gopls.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gotmpl", "gowork" },
    root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            completeUnimported = true,
            usePlaceholders = true,
            staticcheck = true,
        },
    },
})

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        Lua = {
            diagnostics = {
                enable = false, -- Disable all diagnostics from lua_ls
                -- globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})

lspconfig.pyright.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off", -- Disable type checking diagnostics
            },
        },
    },
})

lspconfig.ltex_plus.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    filetypes = { "tex", "latex", "markdown", "plaintex" },
    settings = {
        ltex = {
            language = "en-US", -- Change to your preferred language
            additionalRules = {
                enablePickyRules = true,
                motherTongue = "en-US",
            },
            -- Add custom dictionaries
            dictionary = {
                ["en-US"] = {}, -- Add custom words here
            },
            -- Disable specific rules if needed
            disabledRules = {
                ["en-US"] = {}, -- Add rules to disable here
            },
        },
    },
})
