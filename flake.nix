{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      username = builtins.getEnv "BOWOS_USER";
    in
    {
      nixosConfigurations = {
        
        # NVIDIA Configuration
        nvidia = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              services.xserver.videoDrivers = [ "nvidia" ];
              hardware.nvidia.open = false;
            }
            stylix.nixosModules.stylix
            ./configs/configuration.nix
            ./configs/applications.nix
            {
              networking.hostName = "bowos";
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./configs/home.nix;
            }
          ];
        };

        # AMD Configuration
        amd = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              services.xserver.videoDrivers = [ "amdgpu" ];
            }
            stylix.nixosModules.stylix
            ./configs/configuration.nix
            ./configs/applications.nix
            {
              networking.hostName = "bowos";
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./configs/home.nix;
            }
          ];
        };

        # ISO 
        # Usage: BOWOS_USER=bowyn sudo -E nix build .#nixosConfigurations.iso.config.system.build.isoImage --impure
        iso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              services.xserver.videoDrivers = [ "amdgpu" ];
            }
            stylix.nixosModules.stylix
            ./configs/configuration.nix
            ./configs/applications.nix
            # ISO Building 
            <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
            <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
            <nixpkgs/nixos/modules/system/etc/etc.nix>

            {
              networking.hostName = "bowos";
              isoImage.squashfsCompression = "gzip -Xcompression-level 4";

            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./configs/home.nix;
            }
          ];
        };

        # Installer Configuration
        install = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              services.xserver.videoDrivers = [ "amdgpu" ];
            }
            stylix.nixosModules.stylix
            ./configs/configuration.nix
            {
              networking.hostName = "bowos";
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./configs/home.nix;
            }
          ];
        };

        # KVM Configuration
        kvm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              boot.kernelParams = [
                "intel_iommu=on"
                "vfio-pci.ids=1002:699f,1002:aae0"
                "rd.driver.pre=vfio-pci"
                "video=efifb:off"
                "loglevel=3"
              ];

              boot.initrd.kernelModules = [
                "vfio_pci"
                "vfio"
                "vfio_iommu_type1"
              ];

              boot.extraModprobeConfig = ''
                options vfio-pci ids=1002:699f,1002:aae0
                options kvm ignore_msrs=1
              '';

              services.xserver.videoDrivers = [ "amdgpu" ];
            }
            stylix.nixosModules.stylix
            ./configs/configuration.nix
            ./configs/applications.nix
            ./configs/services.nix
            {
              networking.hostName = "bowos";
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./configs/home.nix;
            }
          ];
        };
      };
    };
}

