local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        go = { "gofumpt", "goimports-reviser", "golines" },
        gowork = { "gofumpt", "goimports-reviser" },
        gomod = { "gofumpt", "goimports-reviser" },
        gotmpl = { "gofumpt", "goimports-reviser" },
        python = { "black" },
    },

    formatters = {
        ["goimports-reviser"] = {
            prepend_args = { "-rm-unused" },
        },
        golines = {
            prepend_args = { "--max-len=80" },
        },
        black = {
            prepend_args = {
                "--fast",
                "--line-length",
                "80",
            },
        },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

return options
