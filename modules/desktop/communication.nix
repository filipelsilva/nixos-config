{ ... }:
{
  flake.modules.nixos.desktop_communication =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        zoom-us
        discord
        slack
      ];
    };
}
