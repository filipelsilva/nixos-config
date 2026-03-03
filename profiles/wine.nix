{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    winetricks
    wineWow64Packages.stagingFull
  ];
}
