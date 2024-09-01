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
