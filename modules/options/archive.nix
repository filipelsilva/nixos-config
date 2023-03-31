{
  config,
  pkgs,
  inputs,
  ...
}: {
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
