{ config, pkgs, ... }:

{
  # Install LSP servers and other packages globally in the user environment
  home.packages = with pkgs; [
    lua-language-server # Lua LSP
    nixd
    jdt-language-server

    #none_ls
    stylua
    statix
    nixpkgs-fmt
    nodejs
    ripgrep
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # Link to external Lua config files
    extraLuaConfig = ''
      ${builtins.readFile ./init.lua}
      ${builtins.readFile ./lua/plugins.lua}
      ${builtins.readFile ./lua/plugins/telescope.lua}
    '';

    # Install Neovim plugins
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      none-ls-nvim
    ];
  };
}
