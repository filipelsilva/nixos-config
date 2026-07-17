{
  pkgs,
  lib,
  ...
}:
{
  # Homebrew is only available on macOS (nix-darwin).
  homebrew = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
      autoUpdate = true;
      upgrade = true;
    };
    casks = [
      "zoom"
      "discord"
      "slack"
      "firefox"
      "chromium"
      "1password"
    ];
  };
}