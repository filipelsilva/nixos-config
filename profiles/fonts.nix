{pkgs, ...}: {
  environment.systemPackages = with pkgs; [font-manager];

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term

      corefonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      font-awesome
      source-han-sans
      source-han-serif
    ];
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Source Han Serif"];
      sansSerif = ["Noto Sans" "Source Han Sans"];
    };
  };
}
