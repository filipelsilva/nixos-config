{pkgs, ...}: {
  environment.systemPackages = with pkgs; [font-manager];

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Iosevka" "IosevkaTerm"];})
      noto-fonts
      noto-fonts-cjk-sans
      corefonts # Microsoft fonts
    ];
  };
}
