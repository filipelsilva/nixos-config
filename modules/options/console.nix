{
  config,
  pkgs,
  inputs,
  ...
}: {
  console = {
    keyMap = "us";
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v20b.psf.gz";
  };
}
