return {
	"jose-elias-alvarez/null-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
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

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
