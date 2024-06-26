{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.sessionVariables = {
    XDG_DATA_HOME = "$HOME/.local/share";
  };
  # Do this for steam TODO automate
  # mkdir -p ~/.local/share/applications
  # sed 's/^Exec=/&nvidia-offload /' /run/current-system/sw/share/applications/steam.desktop > ~/.local/share/applications/steam.desktop

  boot = {
    blacklistedKernelModules = ["nouveau"];
    kernelParams = ["nouveau.modeset=0"];
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      prime = {
        offload = {
          enable = false;
          enableOffloadCmd = lib.mkIf config.hardware.nvidia.prime.offload.enable true;
        };
        sync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
