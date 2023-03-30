{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [font-manager];

  fonts.fonts = with pkgs; [
    iosevka-bin
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    corefonts # Microsoft fonts
  ];
}
