{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (lutris-free.override {
      extraLibraries = pkgs: [
      ];
      extraPkgs = pkgs: [
        wineWowPackages.stagingFull
      ];
    })
  ];
}
