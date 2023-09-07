{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
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
