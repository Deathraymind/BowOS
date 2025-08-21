return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- one on_attach for all servers
    local on_attach = function(_, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end
      map("n", "K", vim.lsp.buf.hover, "LSP Hover")
      map("n", "gd", vim.lsp.buf.definition, "Go to Def")
      map("n", "gr", vim.lsp.buf.references, "Refs")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
      map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format")
    end

    -- nixd
    lspconfig.nixd.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- lua
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    })

    -- java
    lspconfig.jdtls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- C# / Unity (NixOS system OmniSharp)
    local omnipath = vim.fn.exepath("omnisharp") ~= "" and vim.fn.exepath("omnisharp")
      or "/run/current-system/sw/bin/omnisharp"

    lspconfig.omnisharp.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { omnipath, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
      -- If you use omnisharp-extended:
      -- handlers = { ["textDocument/definition"] = require("omnisharp_extended").handler },
    })
  end,
}

