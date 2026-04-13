{ ... }:
{
  flake.modules.nixos.gaming_lutris =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        lutris-free
        wineWow64Packages.stagingFull
      ];
    };
}
