# flake.nix
{
  description = "NixOS configuration";

  inputs = {
    
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; # unstable channel from nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; # nixos stable repository
    
    

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05"; # this downloads the homemanager from github
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      # TODO please change the hostname to your own
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          /etc/nixos/configuration.nix
          
          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            

           
            home-manager.users.bowyn = import /etc/nixos/home.nix; # This lines calls the file home.nix 
            
          }
        ];
      };
    };
  };
}