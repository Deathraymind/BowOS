{
  inputs = {
    stylix.url = "github:danth/stylix";
    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
  };

  outputs = { nixpkgs, home-manager, stylix, ... }@inputs:
    {
      nixosConfigurations."bowos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          stylix.nixosModules.stylix
          ./iso.nix
        ];
      };
    };
}
