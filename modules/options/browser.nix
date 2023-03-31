{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    firefox
    chromium
    tor-browser-bundle-bin
  ];
}
