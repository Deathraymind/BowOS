{ config, pkgs, ... }:

{

programs.neovim = {
  enable = true;
	viAlias = true;
	vimAlias = true;
	vimdiffAlias = true;

	extraLuaConfig =''
${builtins.readFile .init.lua}
${builtins.readFile ./lua/plugins.lua}
${builtins.readFile ./lua/plugins/config/telescope}
        '';
  plugins = with pkgs.vimPlugins ; [




  ]






  };
}
