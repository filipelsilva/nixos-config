{lib, ...}: {
  time.timeZone = "Europe/Lisbon";

  services.timesyncd.enable = lib.mkDefault true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MEASUREMENT = "pt_PT.UTF-8";
      LC_MONETARY = "pt_PT.UTF-8";
      LC_PAPER = "pt_PT.UTF-8";
    };
  };
}
