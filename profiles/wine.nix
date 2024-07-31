{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    winetricks
    wineWowPackages.stagingFull
  ];
}
