{
  inputs = {
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, home-manager, stylix,  ... }@inputs: 
    {
    nixosConfigurations."bowos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        stylix.nixosModules.stylix
        ./iso.nix
      ];
    };
  };
}
