{
  config,
  lib,
  inputs,
  ...
}: {
  time.timeZone = "Europe/Lisbon";

  services.timesyncd.enable = lib.mkDefault true;

  i18n = {
    defaultLocale = "en_US.utf8";
    extraLocaleSettings = {
      LC_MEASUREMENT = "pt_PT.utf8";
      LC_MONETARY = "pt_PT.utf8";
      LC_PAPER = "pt_PT.utf8";
    };
  };
}
