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


-- if shit brokon run these commands 
-- rm -rf ~/.local/share/nvim/lazy/lazy.nvim
-- git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable ~/.local/share/nvim/lazy/lazy.nvim
