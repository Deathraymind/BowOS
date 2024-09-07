#firefox.nix

{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      bookmarks = [
        {
          name = "BowOS";
	  tags = ["wiki"];
	  keyword = "wiki";
	  url = "https://github.com/Deathraymind/BowOS";
        }
      ];
    };
  };

}
