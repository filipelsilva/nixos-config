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
    programs.gnupg.agent = {
      enableExtraSocket = true;
      enableBrowserSocket = true;
      enableSSHSupport = false;
      enable = true;
    };
  };

  homeConfig = {
    programs.gpg.enable = true;
  };
}
