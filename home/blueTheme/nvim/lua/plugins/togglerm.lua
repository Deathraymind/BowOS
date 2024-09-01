return {
    {
      'akinsho/toggleterm.nvim',
      version = "*",
      opts = {
        size = 20,
        open_mapping = [[<C-\>]], -- Make sure this is not <CR>
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        direction = 'horizontal',
        autochdir = true,
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      }
    }
  }
