return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      panel = {
        enabled = true,
        auto_refresh = true,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        

    },
      filetypes = {
        -- Optionally enable/disable for specific file types
        -- yaml = false,
        -- markdown = true,
        -- Help always enables copilot
        help = false,
      },
    })
  end
}
