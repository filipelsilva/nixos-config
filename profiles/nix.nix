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
    nix = {
      optimise = {
        automatic = true;
        persistent = true;
        dates = "weekly";
      };
      gc = {
        automatic = true;
        persistent = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };

    services.envfs.enable = true;

    programs.nix-ld.enable = true;

    environment.pathsToLink = [ "/libexec" ];
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      keep-outputs = true;
      keep-derivations = true;
      auto-optimise-store = true;
      download-buffer-size = 1024 * 1024 * 1024;
      trusted-users = [ "@wheel" ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}
