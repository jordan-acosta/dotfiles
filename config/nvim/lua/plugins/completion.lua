return {
    "saghen/blink.cmp",
    version = "1.*", -- use a release tag so prebuilt fuzzy-matcher binaries are downloaded
    opts = {
        keymap = {
            -- enter preset: <CR> accepts, <C-space> toggles docs, <C-e> hides.
            preset = "enter",
            -- <Tab>/<S-Tab> move the selection (falling back to snippet jumps).
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        completion = {
            -- Show a side panel with docs/signature for the highlighted item.
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
}
