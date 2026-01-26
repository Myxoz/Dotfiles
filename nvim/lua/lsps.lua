-- RUST
vim.lsp.config["rust_analyzer"] = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml" },
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = true,           -- simple check
            inlayHints = {                 -- enable inline hints
                enable = true,
            },
        },
    },
}
vim.lsp.enable("rust_analyzer")

-- PHP
vim.lsp.config["intelephense"] = {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php" },
    root_markers = { "composer.json", ".git/" },
    settings = {
        intelephense = {
            files = {
                maxSize = 5000000; -- optional: allow big projects
            },
        },
    },
}
vim.lsp.enable("intelephense")

-- JS/TS
vim.lsp.config["tsserver"] = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json" },
    root_markers = { "package.json", "tsconfig.json", ".git" },
}
vim.lsp.enable("tsserver")

-- HTML
vim.lsp.config["html"] = {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    root_markers = { ".git", "composer.json", "package.json" },
}
vim.lsp.enable("html")
vim.lsp.config["cssls"] = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_markers = { ".git", "composer.json", "package.json" },
}
vim.lsp.enable("cssls")
