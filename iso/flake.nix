{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, stylix, ... }: {
    nixosConfigurations.bowos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./iso.nix
        stylix.nixosModules.stylix
      ];
    };
  };
}
