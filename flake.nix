{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    rocm.url = "github:nixos-rocm/nixos-rocm";
    disko.url = "github:nix-community/disko/latest"; # For Installer
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, rocm, disko, ... }@inputs:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      username = builtins.getEnv "BOWOS_USER";
    in
    {
      nixosConfigurations = {
        nvidia = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              # NVIDIA configuration
              services.xserver.videoDrivers = [ "nvidia" ];
              hardware.nvidia.open = false;
            }
            stylix.nixosModules.stylix
            ./hosts/default/configuration.nix
            {
              networking.hostName = "bowos";
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./hosts/default/home.nix;
            }
          ];
        };

        amd = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              # AMD configuration
              services.xserver.videoDrivers = [ "amdgpu" ];
            }
            stylix.nixosModules.stylix
            ./hosts/default/configuration.nix
            /mnt/etc/nixos/hardware-configuration.nix


            {
              networking.hostName = "bowos";
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./hosts/default/home.nix;
            }
          ];
        };

        install = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              services.xserver.videoDrivers = [ "amdgpu" ];
            }
            stylix.nixosModules.stylix
            ./hosts/default/configuration.nix
            disko.nixosModules.disko
            ./disko.nix
            {
              networking.hostName = "bowos";
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./hosts/default/home.nix;
            }
          ];
        };


        kvm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {

              # KVM configuration
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
            ./hosts/default/configuration.nix
            {
              networking.hostName = "bowos";
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./hosts/default/home.nix;
            }
          ];
        };
      };
    };
}

