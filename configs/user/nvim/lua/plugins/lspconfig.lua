
return {
'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities() -- This is needed for settiing up auto completions by reaching out to the lsp servers

    lspconfig.nixd.setup({
        capabilities = capabilities
        })
    lspconfig.lua_ls.setup({
        capabilities = capabilities
        })
    lspconfig.jdtls.setup({
        capabilities = capabilities
        })

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
    vim.keymap.set({ 'n' }, '<leader>ca', vim.lsp.buf.code_action, {})
  end

}
