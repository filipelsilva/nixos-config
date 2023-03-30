{
  config,
  pkgs,
  inputs,
  ...
}: {
  time.timeZone = "Europe/Lisbon";

  i18n = {
    defaultLocale = "en_US.utf8";
    extraLocaleSettings = {
      LC_MEASUREMENT = "pt_PT.utf8";
      LC_MONETARY = "pt_PT.utf8";
      LC_PAPER = "pt_PT.utf8";
    };
  };

  console = {
    # earlySetup = true;
    # useXkbConfig = true; # TODO não funciona
    # font = "${pkgs.terminus_font}/share/consolefonts/ter-v20b.psf.gz";
    font = "Lat2-Terminus16"; # TODO pode não funcionar
    keyMap = "us";
  };

  environment = {
    pathsToLink = ["/libexec"];
  };
}
