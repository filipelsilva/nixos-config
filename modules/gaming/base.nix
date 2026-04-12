{ pkgs, ... }:
{
  flake.modules.nixos.gaming_base =
    { pkgs, ... }:
    {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libvdpau-va-gl
        ];
      };
    };
}
