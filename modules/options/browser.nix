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
    ];
    sessionVariables = {
      MOZ_USE_XINPUT2 = "1";
    };
  };
}
