vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.name == "html" or client.name == "cssls" then
            client.server_capabilities.documentFormattingProvider = false
        end
        local opts = { buffer = bufnr }
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>fm", function()
			if vim.bo.filetype == "json" then
				vim.cmd("%!jq .")
			else
				vim.lsp.buf.format()
			end
		end, { desc = "Format file" })
        vim.keymap.set("n", "<leader>j", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>a", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "F", vim.lsp.buf.format, opts)
    end,
})
