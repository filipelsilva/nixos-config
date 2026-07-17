{
  lib,
  pkgs,
  system,
  ...
}:
let
  isLinux = lib.hasSuffix "linux" system;
in
{
  imports = lib.optional isLinux {
    services = {
      timesyncd.enable = lib.mkDefault true;
      automatic-timezoned.enable = true;
    };

    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_MEASUREMENT = "pt_PT.UTF-8";
        LC_MONETARY = "pt_PT.UTF-8";
        LC_PAPER = "pt_PT.UTF-8";
      };
    };
  };

  time.timeZone = lib.mkIf (!isLinux) "Europe/Lisbon";
}
