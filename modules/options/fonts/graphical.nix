{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [font-manager];

  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;
    fonts = with pkgs; [
      iosevka-bin
      noto-fonts
      noto-fonts-cjk
      corefonts # Microsoft fonts
    ];
  };
}
