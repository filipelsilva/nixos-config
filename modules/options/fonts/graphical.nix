{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [font-manager];

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      iosevka-bin
      noto-fonts
      noto-fonts-cjk
      corefonts # Microsoft fonts
    ];
  };
}
