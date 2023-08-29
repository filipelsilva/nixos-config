{pkgs}: {
  environment.systemPackages = with pkgs; [
    atool
    gzip
    zip
    unzip
    p7zip
    fastjar
    rar
  ];
}
