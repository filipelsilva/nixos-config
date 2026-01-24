{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lutris-free
    wineWowPackages.stagingFull
  ];
}
