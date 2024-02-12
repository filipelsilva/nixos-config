{...}: {
  system.stateVersion = "23.11";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      keep-outputs = true;
      keep-derivations = true;
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  services.envfs.enable = true;

  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment = {
    pathsToLink = ["/libexec"];
  };
}
