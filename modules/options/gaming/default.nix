{pkgs, ...}: {
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = pkgs.system == "x86_64-linux";
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver
      ];
    };
  };
  imports = [
    ./steam.nix
    ./lutris.nix
    ./heroic.nix
  ];
}
