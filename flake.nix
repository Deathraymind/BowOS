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


                              hardware.nvidia = {
    modesetting.enable = true;          # required for Wayland
    powerManagement.enable = true;      # optional but useful
    nvidiaSettings = true;              # allows nvidia-settings GUI
    open = false;                       # required for GTX 1080 (no open driver support)
  };

  boot.kernelParams = [ "nvidia-drm.modeset=1" ]; # important for Wayland
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

        # AMD Configuration
        amd = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              services.xserver.videoDrivers = [ "amdgpu" ];
            hardware.opengl = {
  enable = true;
  driSupport = true;
  driSupport32Bit = true;
};

hardware.amdgpu = {
  enable = true;
};
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
              networking.hostName = "bowos";
              isoImage.squashfsCompression = "gzip -Xcompression-level 4";
              isoImage.isoBaseName = "BowOS";
              isoImage.volumeID = "BowOS";
              isoImage.edition = "-TUI";
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
            # AI stuff for AMD
                            # hardware.amdgpu.opencl.enable = true;
                            # hardware.graphics.extraPackages = [ pkgs.rocmPackages.clr.icd ];
                            # environment.systemPackages = [ pkgs.rocmPackages.clr.icd ];
                            # systemd.tmpfiles.rules = [
                            # "L+ /opt/rocm - - - - ${pkgs.rocmPackages.clr}" 
                            # ];


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
              hardware.opengl = {
                enable = true;
                driSupport32Bit = true;
              };

            }
            stylix.nixosModules.stylix
            ./configs/configuration.nix
            ./configs/applications.nix
            ./configs/services.nix
            ./configs/ollama.nix
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

