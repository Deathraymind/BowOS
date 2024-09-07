{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile ./init.lua}
      ${builtins.readFile ./lua/plugins.lua}
      ${builtins.readFile ./lua/plugins/telescope.lua}
    '';

    plugins = with pkgs.vimPlugins; [
      {
      plugin = nvim-lspconfig;
      }
    ];
  };
}
