-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.loop or vim.uv).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." }
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
local status, lazy = pcall(require, "lazy")
if not status then
  print("Error loading lazy.nvim: " .. lazy)
  return
end

lazy.setup({
  spec = {
    -- add your plugins here
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

-- Set leader keys and mappings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.api.nvim_set_keymap('n', 'yy', 'yy"+yy', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-x>', ':lcd %:p:h<CR>:ToggleTerm<CR>', { noremap = true, silent = true })
