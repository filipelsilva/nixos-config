{pkgs, ...}: {
  console = {
    packages = with pkgs; [
      terminus_font
    ];
    keyMap = "us";
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32b.psf.gz";
  };
}
