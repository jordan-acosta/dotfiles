return {
    "saghen/blink.cmp",
    version = "1.*", -- use a release tag so prebuilt fuzzy-matcher binaries are downloaded
    opts = {
        keymap = { preset = "default" }, -- <C-space> open, <C-y> accept, <C-n>/<C-p> navigate
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
}
