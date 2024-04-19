{
  lib,
  pkgs,
  headless ? false,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      onionshare
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      tor-browser
      onionshare-gui
      ricochet-refresh
    ]);
}
