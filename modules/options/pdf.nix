{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pandoc
    zathura
    diffpdf
  ];
}
