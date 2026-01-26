-- Enable completion menu
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Tab completion behavior
vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-n>"  -- Next item
    else
        return "<Tab>"
    end
end, { expr = true })

vim.keymap.set("i", "<S-Tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-p>"  -- Previous item
    else
        return "<S-Tab>"
    end
end, { expr = true })

-- Enter to confirm selection
vim.keymap.set("i", "<CR>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-y>"  -- Confirm selection
    else
        return "<CR>"
    end
end, { expr = true })

-- Trigger completion manually with Ctrl+Space
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>")

-- === nvim-cmp (inline autocomplete) ===
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    print("nvim-cmp not found!")
    return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
    print("LuaSnip not found!")
    return
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<Up>"]   = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({ select = true })
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping(function(fallback)
            fallback()
        end, { "i", "s" }),
		["<C-Space>"] = cmp.mapping.complete(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
    completion = {
	    autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
	    completeopt = "menu,menuone,noselect",
    }
})

-- Optional: enable inline LSP hints (Neovim 0.9+)
if vim.lsp.buf.inlay_hint and type(vim.lsp.buf.inlay_hint) == "function" then
    vim.lsp.buf.inlay_hint(0, true)
end
vim.diagnostic.config({ virtual_text = true })
vim.opt.signcolumn = "yes" -- Left padding even if no errors
