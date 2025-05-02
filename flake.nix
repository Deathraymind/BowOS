{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, stylix,... }@inputs:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      username = builtins.getEnv "BOWOS_USER";
    in
    {
      nixosConfigurations = {
        


        # AMD Configuration
        server = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            stylix.nixosModules.stylix
            ./configs/configuration.nix
            ./configs/applications.nix
            ./configs/services.nix

            {
              networking.hostName = "bowos-server";
            }
          ];
        };

        install = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            stylix.nixosModules.stylix
            ./configs/configuration.nix
            ./configs/applications.nix
            ./configs/services.nix

            {
              networking.hostName = "bowos-server";
            }
          ];
        };

        # ISO 
        # Usage: BOWOS_USER=bowyn sudo -E nix build .#nixosConfigurations.iso.config.system.build.isoImage --impure
        # TODO: https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/installer/cd-dvd/iso-image.nix
        iso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              services.xserver.videoDrivers = [ "amdgpu" ];
            }
            stylix.nixosModules.stylix
            ./configs/iso-configuration.nix
            # ISO Building 
            <nixpkgs/nixos/modules/installer/cd-dvd/iso-image.nix>

            {
              networking.hostName = "bowos-server";
              isoImage.squashfsCompression = "gzip -Xcompression-level 4";
              isoImage.isoBaseName = "BowOS-server";
              isoImage.volumeID = "BowOS-server";
              isoImage.edition = "-TUI";
            }
          ];
        };
      };
    };
}

