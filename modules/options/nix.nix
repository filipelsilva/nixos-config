{
  config,
  pkgs,
  inputs,
  ...
}: {
  system = {
    stateVersion = "22.11";
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
      min-free = 104857600
    '';
    settings.auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    pathsToLink = ["/libexec"];
  };
}
