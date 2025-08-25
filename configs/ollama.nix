{ config, pkgs, lib, ... }:
let
  unstable = import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
    system = pkgs.system;
  };
in
{
  #########################
  ## GPU & ROCm plumbing ##
  #########################
  hardware.graphics = {
    enable = true;
    enable32Bit = true;     # safe to keep on
  };

  hardware.enableRedistributableFirmware = true;

  # Make sure amdgpu is available from early boot and in the live system
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "amdgpu" ];

  # You need access to /dev/kfd and /dev/dri/*
  users.users.bowyn.extraGroups = [ "video" "render" ];

  ########################
  ## Ollama (ROCm)
  ########################
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    rocmOverrideGfx = "10.3.0";     # matches your HSA override
    # If your module exposes it, this is cleaner than OLLAMA_HOST:
    # listenAddress = "0.0.0.0:11434";
  };

  # Put ROCm libraries on the loader path so Ollama can find them
  # (rocBLAS + hipBLAS + hipBLASLt are the important ones)
  systemd.services.ollama.serviceConfig.Environment = [
    "LD_LIBRARY_PATH=${lib.makeLibraryPath [
      pkgs.rocmPackages.rocblasq
      pkgs.rocmPackages.hipblas
    ]}"
  ];

  environment.systemPackages = with pkgs; [
    unstable.ollama
    rocmPackages.rocminfo     # `rocminfo` to verify ROCm sees your GPU
    rocmPackages.rocm-smi     # diagnostics
    rocmPackages.rocblas
    rocmPackages.hipblas
    rocmPackages.clr          # OpenCL runtime (harmless to keep)
  ];

  environment.variables = {
    # Use either the service option above or this; don’t mix URL scheme:
    OLLAMA_HOST = "0.0.0.0:11434";

    # Force GFX if autodetect is flaky (you already had this)
    HSA_OVERRIDE_GFX_VERSION = "10.3.0";

    # Optional: pick the GPU index explicitly
    HIP_VISIBLE_DEVICES = "0";
    ROCR_VISIBLE_DEVICES = "0";
  };
}

