{pkgs, ...}: {
  environment.systemPackages = with pkgs; [font-manager];

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      noto-fonts
      noto-fonts-cjk-sans
      corefonts # Microsoft fonts
    ];
  };
}
