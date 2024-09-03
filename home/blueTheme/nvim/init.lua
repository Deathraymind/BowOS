-- Install lazy.nvim if not already installed
require("config.lazy")





-- lazy.setup("plugins")  -- Ensure "plugins.lua" exists in your config directory

-- Set leader key
vim.g.mapleader = " "

-- Map yy to yank to both the default register and the system clipboard
vim.api.nvim_set_keymap('n', 'yy', 'yy"+yy', { noremap = true, silent = true })

-- Map Ctrl-x to open terminal in the current directory
vim.api.nvim_set_keymap('n', '<C-x>', ':lcd %:p:h<CR>:ToggleTerm<CR>', { noremap = true, silent = true })
