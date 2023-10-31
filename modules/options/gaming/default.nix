{pkgs, ...}: {
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
      extraPackages32 = pkgs.lib.mkForce [pkgs.linuxPackages_latest.nvidia_x11.lib32];
    };
  };
  imports = [
    ./steam.nix
    ./lutris.nix
    ./heroic.nix
  ];
}
