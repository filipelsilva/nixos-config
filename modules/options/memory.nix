{
  pkgs,
  lib,
  headless ? false,
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
    ++ lib.lists.optionals (!headless) (with pkgs; [
      gparted
    ]);
}
