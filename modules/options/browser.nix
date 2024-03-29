{pkgs, ...}: {
  programs = {
    firefox = {
      enable = true;
      languagePacks = ["en-US" "pt-PT"];
    };
    chromium.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      chromium
      tor-browser-bundle-bin
    ];
    sessionVariables = {
      MOZ_USE_XINPUT2 = "1";
    };
  };
}
