
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, stylix,  ... }@inputs: 
    let
      username = builtins.getEnv "BOWOS_USER";
    in
    {



    # nvidia configuration
    nixosConfigurations."nvidia" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
            # NIXOS CONFIGURATION
            services.xserver.videoDrivers = ["nvidia"];
            hardware.nvidia.open = false;
        }
        stylix.nixosModules.stylix
        ./hosts/default/configuration.nix
        {
        networking.hostName = "bowos";
        }
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./hosts/default/home.nix;
        }
      ];
    };



    nixosConfigurations."amd" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
            # NIXOS CONFIGURATION
            services.xserver.videoDrivers = ["amdgpu"];
        }
        stylix.nixosModules.stylix
        ./hosts/default/configuration.nix
        {
        networking.hostName = "bowos";
        }
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./hosts/default/home.nix;
        }
      ];
    };










  };
}
