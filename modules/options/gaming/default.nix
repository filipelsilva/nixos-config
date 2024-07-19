{pkgs, ...}: {
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver
        # intel-vaapi-driver
        nvidia-vaapi-driver
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
