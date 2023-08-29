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
    gc.automatic = true;
    settings = {
      keep-outputs = true;
      keep-derivations = true;
      auto-optimise-store = true;
    };
  };

  services.envfs.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment = {
    pathsToLink = ["/libexec"];
  };
}
