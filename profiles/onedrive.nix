{
  pkgs,
  lib,
  system,
  ...
}:
let
  isLinux = lib.hasSuffix "linux" system;
in
{
  environment.systemPackages = with pkgs; lib.lists.optionals isLinux [
    onedrive
  ];
}
