{
  description = "NixOS configuration";

  inputs = {
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";  # Use the unstable channel from Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";     # NixOS stable repository

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";  # Home Manager from GitHub
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bowyn = import ./home.nix;  # Load user-specific configuration
          }
        ];
      };
    };
  };
}