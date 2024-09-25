{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.sessionVariables = {
    XDG_DATA_HOME = "$HOME/.local/share";
  };

  homeConfig = lib.attrsets.optionalAttrs (config.hardware.nvidia.prime.offload.enable) {
    home.file.".local/share/applications/steam.desktop".text = lib.replaceStrings ["Exec="] ["Exec=nvidia-offload "] (lib.readFile "${pkgs.steam}/share/applications/steam.desktop");
  };

  boot = {
    blacklistedKernelModules = ["nouveau"];
    kernelParams = ["i915.force_probe=7d55" "nvidia_drm.fbdev=1"];
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      prime = {
        offload = {
          enable = false;
          enableOffloadCmd = config.hardware.nvidia.prime.offload.enable;
        };
        sync.enable = !config.hardware.nvidia.prime.offload.enable;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
