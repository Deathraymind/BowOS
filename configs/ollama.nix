{ config, pkgs, inputs, lib, ... }:
{
services.ollama = {
  enable = true;
  acceleration = "rocm";   # Use ROCm (AMD GPU) for acceleration
  # Optional: Preload models at startup (for example, DeepSeek):
  loadModels = [ "deepseek-r1:14b" ];
  # If needed, override GPU GFX version (see below)
  # rocmOverrideGfx = "gfx1031";
};
}
