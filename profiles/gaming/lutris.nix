{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris-free
    wineWow64Packages.stagingFull
  ];
}
