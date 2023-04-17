{
  config,
  pkgs,
  lib,
  headless ? true,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  hardware.opengl.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  # hardware.nvidia.modesetting.enable = true;
}
