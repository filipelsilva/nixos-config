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

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    opengl.extraPackages32 = pkgs.lib.mkForce [pkgs.linuxPackages_latest.nvidia_x11.lib32];
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = lib.mkIf config.hardware.nvidia.prime.offload.enable true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
