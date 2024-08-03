{
  lib,
  pkgs,
  headless,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      tor
      onionshare
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      tor-browser
      onionshare-gui
      ricochet-refresh
    ]);
}
