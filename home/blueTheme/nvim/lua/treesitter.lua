return {
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate"
    config = funtion()
    local config = require("nvim-treesitter.configs")
    config.setup({
    ensure_installed = {"lua", "javascript"},
    highlight = {enable = true},
    indent = {enable = true},
    })
    end
},