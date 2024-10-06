{pkgs, ...}: {
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
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
