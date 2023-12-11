{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    man
    man-pages
    man-pages-posix
  ];

  documentation = {
    enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
    info.enable = true;
    doc.enable = true;
    dev.enable = true;
    nixos.enable = true;
  };
}
