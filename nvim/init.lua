-- Treesiter buissiness
require("vim_def")
require("keymap")
require("lsp_config")
require("lsps")
-- We use this to have mixed language support like in .php files

-- Stop fucking with my <>|
local function applyForFUCKINGALLMODES(lhs, rhs, opts)
	vim.keymap.set({'n','i','v','x','s','o','c','t','l'}, lhs, rhs, opts)
end

applyForFUCKINGALLMODES('<S-lt>', '>', { noremap = true, silent = true })
