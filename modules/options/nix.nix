{
  config,
  pkgs,
  inputs,
  ...
}: {
  system.stateVersion = "22.11";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    pathsToLink = ["/libexec"];
  };
}
