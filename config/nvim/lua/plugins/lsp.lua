return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "saghen/blink.cmp",
    },
    config = function()
        require("mason").setup()
        -- Auto-install (and, on 0.11+, auto-enable) the listed servers.
        require("mason-lspconfig").setup({
            ensure_installed = { "gopls" },
        })

        -- Give every server blink.cmp's completion capabilities.
        vim.lsp.config("*", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
        })

        -- gopls: import unimported packages during completion
        -- (was `go.goplsOptions.completeUnimported` in coc-settings.json).
        vim.lsp.config("gopls", {
            settings = {
                gopls = {
                    completeUnimported = true,
                },
            },
        })

        vim.lsp.enable("gopls")

        -- Show diagnostic text inline, and a bordered float with the source.
        vim.diagnostic.config({
            virtual_text = true,
            float = { border = "rounded", source = true },
        })

        -- Buffer-local LSP keymaps, set when a server attaches
        -- (replacing the coc GoTo / rename mappings).
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local opts = { buffer = args.buf, silent = true }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                -- Show the full diagnostic(s) for the current line in a float.
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
            end,
        })

        -- Go: organize imports + format on save
        -- (was coc formatOnSave + the editor.action.organizeImport autocmd).
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function(args)
                local clients = vim.lsp.get_clients({ bufnr = args.buf, name = "gopls" })
                if #clients == 0 then
                    return
                end
                local enc = clients[1].offset_encoding or "utf-16"

                local params = vim.lsp.util.make_range_params(0, enc)
                params.context = { only = { "source.organizeImports" }, diagnostics = {} }
                local result = vim.lsp.buf_request_sync(args.buf, "textDocument/codeAction", params, 3000)
                for _, res in pairs(result or {}) do
                    for _, action in pairs(res.result or {}) do
                        if action.edit then
                            vim.lsp.util.apply_workspace_edit(action.edit, enc)
                        end
                    end
                end

                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
}
