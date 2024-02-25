{pkgs, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    opengl.extraPackages32 = pkgs.lib.mkForce [pkgs.linuxPackages_latest.nvidia_x11.lib32];
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
