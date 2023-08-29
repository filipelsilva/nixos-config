{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pandoc
    pdftk
    libsForQt5.okular
    zathura
    ocamlPackages.cpdf
    diffpdf
  ];
}
