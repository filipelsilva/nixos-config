{
  config,
  inputs,
  ...
}: {
  console = {
    # earlySetup = true;
    useXkbConfig = true; # TODO não funciona
    # font = "${pkgs.terminus_font}/share/consolefonts/ter-v20b.psf.gz";
    font = "Lat2-Terminus16"; # TODO pode não funcionar
    keyMap = "us";
  };
}
