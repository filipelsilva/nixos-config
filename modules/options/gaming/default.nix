{pkgs, ...}: {
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        intel-compute-runtime
        libGL

        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ];
    };
  };

  imports = [
    ./steam.nix
    ./lutris.nix
    ./heroic.nix
    ./minecraft.nix
  ];
}
