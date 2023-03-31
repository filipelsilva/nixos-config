{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    man
    man-pages
    man-pages-posix
  ];

  documentation.dev.enable = true;
}
