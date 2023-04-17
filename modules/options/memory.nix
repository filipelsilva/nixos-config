{
  config,
  pkgs,
  lib,
  headless ? false,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      duf
      du-dust
      diskus
      ncdu
      dua
      fdupes
      parted
    ]
    ++ lib.optional (!headless) pkgs.gparted;
}
