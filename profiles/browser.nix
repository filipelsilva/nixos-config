{
  pkgs,
  lib,
  system,
  ...
}:
let
  isLinux = lib.hasSuffix "linux" system;
in
{
  imports = lib.optional isLinux {
    programs = {
      firefox = {
        enable = true;
        languagePacks = [
          "en-US"
          "pt-PT"
        ];
      };
      chromium.enable = true;
    };

    environment.sessionVariables = {
      MOZ_USE_XINPUT2 = "1";
    };
  };
}
