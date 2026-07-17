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
  imports = lib.optional isLinux {
    services.cron.enable = true;
  };

  environment.systemPackages = with pkgs; lib.lists.optionals isLinux [
    at
  ];
}
