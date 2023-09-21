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
      gdu
      dua
      fdupes
      parted
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      gparted
    ]);
}
