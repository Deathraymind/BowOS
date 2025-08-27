return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("none-ls")  -- or require("null-ls") if you prefer
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.code_actions.statix,
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.nixpkgs_fmt,
        null_ls.builtins.diagnostics.checkstyle,
        null_ls.builtins.formatting.astyle,
      },
    })

    -- format on demand
    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({ async = false })
    end, { desc = "Format buffer" })

    -- optional: format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function() vim.lsp.buf.format({ async = false }) end,
    })
  end,
}

