
return {
'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')


    lspconfig.nixd.setup{}
    lspconfig.lua_ls.setup{}
    
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
    vim.keymap.set({ 'n' }, '<leader>ca', vim.lsp.buf.code_action, {})
  end

}
