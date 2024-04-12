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
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
        # vaapiVdpau
        # intel-compute-runtime
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
