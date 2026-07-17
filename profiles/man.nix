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
    documentation = {
      enable = true;
      man = {
        enable = true;
        cache.enable = true;
      };
      info.enable = true;
      doc.enable = true;
      dev.enable = true;
      nixos.enable = true;
    };
  };

  environment.systemPackages = with pkgs; lib.lists.optionals isLinux [
    man
    man-pages
    man-pages-posix
  ];
}
