{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [font-manager];

  fonts = {
    fontDir.enable = true;
    fontconfig.defaultFonts.monospace = "Iosevka";
    fonts = with pkgs; [
      iosevka-bin
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      corefonts # Microsoft fonts
    ];
  };
}
