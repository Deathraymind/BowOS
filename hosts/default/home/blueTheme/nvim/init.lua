local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {}
vim.g.mapleader = " "
require("lazy").setup("plugins")

-- Map yy to yank to both the default register and the system clipboard
vim.api.nvim_set_keymap('n', 'yy', 'yy"+yy', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-x>', ':lcd %:p:h<CR>:ToggleTerm<CR>', { noremap = true, silent = true }) --This is for toggleterm ctrl x will open temrinal in current directory

vim.opt.tabstop = 4         -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 4      -- Number of spaces to use for autoindent
vim.opt.expandtab = true    -- Use spaces instead of tabs
vim.keymap.set('i', '<A-a>', function()
  require('copilot.suggestion'):accept()
end, { desc = 'Accept full Copilot suggestion' })

