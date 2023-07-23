{
  config,
  pkgs,
  inputs,
  ...
}: {
  system.stateVersion = "23.11";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    settings.auto-optimise-store = true;
    gc.automatic = true;
  };

  services.envfs.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment = {
    pathsToLink = ["/libexec"];
  };
}
