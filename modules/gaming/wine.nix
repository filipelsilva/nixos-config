{ ... }:
{
  flake.modules.nixos.gaming_wine =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        winetricks
        wineWow64Packages.stagingFull
      ];
    };
}
