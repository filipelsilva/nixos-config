{
  pkgs,
  lib,
  headless,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      gdu
      fdupes
      parted
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      gparted
    ]);
}
